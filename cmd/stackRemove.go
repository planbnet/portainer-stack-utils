package cmd

import (
	"github.com/greenled/portainer-stack-utils/client"
	"github.com/greenled/portainer-stack-utils/common"
	"github.com/sirupsen/logrus"
	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// stackRemoveCmd represents the remove command
var stackRemoveCmd = &cobra.Command{
	Use:     "remove STACK_NAME",
	Short:   "Remove a stack",
	Aliases: []string{"rm", "down"},
	Example: "psu stack rm mystack",
	Args:    cobra.ExactArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		portainerClient, clientRetrievalErr := common.GetClient()
		common.CheckError(clientRetrievalErr)

		stackName := args[0]
		endpointId := viper.GetInt32("stack.remove.endpoint")
		var endpointSwarmClusterId string
		var stack client.Stack

		// Guess EndpointID if not set
		if endpointId == 0 {
			logrus.Warning("Endpoint ID not set")
			endpoint, err := common.GetDefaultEndpoint()
			common.CheckError(err)
			endpointId = int32(endpoint.Id)
			logrus.WithFields(logrus.Fields{
				"endpoint": endpointId,
			}).Debug("Using the only available endpoint")
		}

		var selectionErr, stackRetrievalErr error
		endpointSwarmClusterId, selectionErr = common.GetEndpointSwarmClusterId(uint32(endpointId))
		switch selectionErr.(type) {
		case nil:
			// It's a swarm cluster
			logrus.WithFields(logrus.Fields{
				"stack":    stackName,
				"endpoint": endpointId,
				"swarm":    endpointSwarmClusterId,
			}).Debug("Getting stack")
			stack, stackRetrievalErr = common.GetStackByName(stackName, endpointSwarmClusterId, uint32(endpointId))
			common.CheckError(stackRetrievalErr)
		case *common.StackClusterNotFoundError:
			// It's not a swarm cluster
			logrus.WithFields(logrus.Fields{
				"stack":    stackName,
				"endpoint": endpointId,
			}).Debug("Getting stack")
			stack, stackRetrievalErr = common.GetStackByName(stackName, "", uint32(endpointId))
			common.CheckError(stackRetrievalErr)
		default:
			// Something else happened
			common.CheckError(selectionErr)
		}
		logrus.WithFields(logrus.Fields{
			"stack": stackName,
		}).Debug("Getting stack")
		stack, err := common.GetStackByName(stackName, "", 0)

		switch err.(type) {
		case nil:
			// The stack exists
			stackId := stack.Id

			logrus.WithFields(logrus.Fields{
				"stack": stackName,
			}).Info("Removing stack")
			err = portainerClient.DeleteStack(stackId)
			common.CheckError(err)
		case *common.StackNotFoundError:
			// The stack does not exist
			logrus.WithFields(logrus.Fields{
				"stack": stackName,
			}).Debug("Stack not found")
			if viper.GetBool("stack.remove.strict") {
				logrus.WithFields(logrus.Fields{
					"stack": stackName,
				}).Fatal("Stack does not exist")
			}
		default:
			// Something else happened
			common.CheckError(err)
		}
	},
}

func init() {
	stackCmd.AddCommand(stackRemoveCmd)

	stackRemoveCmd.Flags().Bool("strict", false, "Fail if stack does not exist.")
	stackRemoveCmd.Flags().Uint32("endpoint", 0, "Endpoint ID.")
	viper.BindPFlag("stack.remove.strict", stackRemoveCmd.Flags().Lookup("strict"))
	viper.BindPFlag("stack.remove.endpoint", stackRemoveCmd.Flags().Lookup("endpoint"))
}

targetScope='subscription'

@description('Location for all resources.')
param location string = deployment().location

resource newRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'resourceGroupName0101'
  location: location
}

// @description('Prefix for all resources created by this template')
// param prefix string

// @secure()
// param sqlAdministratorLogin string

// @secure()
// param sqlAdministratorLoginPassword string

// //Setup resource names
// var planName = '${prefix}-plan'
// var apiAppName = '${prefix}-api-app'
// var sqlServerName = '${prefix}-sql-server'
// var sqlDatabaseName = '${prefix}-db'

// //Create the App Service Plan
// module planModule './modules/appServicePlan.bicep' = {
//   name: planName
//   scope: resourceGroup('b798c28b-e334-4ecf-b338-ec314ced3616', 'example-rg')
//   params: {
//     location: location
//     planName: planName
//   }
// }

// //Create the API App Service
// module apiAppModule './modules/appService.bicep' = {
//   name: apiAppName
//   scope: resourceGroup('b798c28b-e334-4ecf-b338-ec314ced3616', 'example-rg')
//   params: {
//     location: location
//     appName: apiAppName
//     planId: planModule.outputs.planId
//     connectionStrings: [{
//       connectionString: 'Server=tcp:${sqlServerModule.outputs.serverFullyQualifiedDomainName},1433;Initial Catalog=${sqlDatabaseName};Persist Security Info=False;User ID=${sqlAdministratorLogin};Password=${sqlAdministratorLoginPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
//       name: 'SampleApiContext'
//       type: 'SQLAzure'
//     }]
//     useAuth: false
//     isApi: true
//   }
// }

// //Create the SQL Server
// module sqlServerModule './modules/sqlServer.bicep' = {
//   name: sqlServerName
//   scope: resourceGroup('b798c28b-e334-4ecf-b338-ec314ced3616', 'example-rg')
//   params: {
//     location: location
//     sqlServerName: sqlServerName
//     sqlAdministratorLogin: sqlAdministratorLogin
//     sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
//     useAzureAdAuth: false
//     usePrivateNetworking: false
//   }
// }

// //Create the SQL Database
// module databaseModule './modules/sqlDatabase.bicep' = {
//   name: sqlDatabaseName
//   scope: resourceGroup('b798c28b-e334-4ecf-b338-ec314ced3616', 'example-rg')
//   params: {
//     location: location
//     sqlServerName: sqlServerModule.outputs.serverName
//     databaseName: sqlDatabaseName
//   }
// }

// // Output data used in the pipeline
// output serverFullyQualifiedDomainName string = sqlServerModule.outputs.serverFullyQualifiedDomainName

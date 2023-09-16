@description('Location for all resources.')
param location1 string = 'Uk South'

@description('Prefix for all resources created by this template')
param prefix string

@secure()
param sqlAdministratorLogin string

@secure()
param sqlAdministratorLoginPassword string

//Setup resource names
var planName = '${prefix}-plan102030'
var apiAppName = '${prefix}-api-app102030'
var sqlServerName = '${prefix}-sql-server102030'
var sqlDatabaseName = '${prefix}-db102030'

//Create the App Service Plan
module planModule './modules/appServicePlan.bicep' = {
  name: planName
  params: {
    location: location1
    planName: planName
  }
}

//Create the API App Service
module apiAppModule './modules/appService.bicep' = {
  name: apiAppName
  params: {
    location: location1
    appName: apiAppName
    planId: planModule.outputs.planId
    connectionStrings: [{
      connectionString: 'Server=tcp:${sqlServerModule.outputs.serverFullyQualifiedDomainName},1433;Initial Catalog=${sqlDatabaseName};Persist Security Info=False;User ID=${sqlAdministratorLogin};Password=${sqlAdministratorLoginPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
      name: 'SampleApiContext'
      type: 'SQLAzure'
    }]
    useAuth: false
    isApi: true
  }
}

//Create the SQL Server
module sqlServerModule './modules/sqlServer.bicep' = {
  name: sqlServerName
  params: {
    location: location1
    sqlServerName: sqlServerName
    sqlAdministratorLogin: sqlAdministratorLogin
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
    useAzureAdAuth: false
    usePrivateNetworking: false
  }
}

//Create the SQL Database
module databaseModule './modules/sqlDatabase.bicep' = {
  name: sqlDatabaseName
  params: {
    location: location1
    sqlServerName: sqlServerModule.outputs.serverName
    databaseName: sqlDatabaseName
  }
}

//Output data used in the pipeline
output serverFullyQualifiedDomainName string = sqlServerModule.outputs.serverFullyQualifiedDomainName

import jenkins.model.*
import hudson.security.*

// Get Jenkins instance
def instance = Jenkins.getInstance()

// Get the Jenkins root directory
def jenkinsRootDir = instance.getRootDir()

// Read the initial admin password
def initialAdminPasswordFile = new File(jenkinsRootDir, "secrets/initialAdminPassword")
def initialAdminPassword = initialAdminPasswordFile.text.trim()

// Log the initial admin password (for demonstration purposes)
println("Initial Admin Password: ${initialAdminPassword}")

// Create admin user with the initial admin password
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", initialAdminPassword)
instance.setSecurityRealm(hudsonRealm)

// Set authorization strategy (Full access for admin user)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

// Save the changes
instance.save()

println("Admin user created with username 'admin' and the initial admin password.")

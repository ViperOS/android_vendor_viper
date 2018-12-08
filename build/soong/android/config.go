package android

// Global config used by Viper soong additions
var ViperConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.lineageos.hardware",
	},
}

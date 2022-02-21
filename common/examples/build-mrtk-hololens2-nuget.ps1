Import-Module UnitySetup

write-output "$env:LIC" >> $env:TMP\Unity_lic.ulf
Start-UnityEditor -BatchMode -Quit -LogFile $pwd\Logs\Activation.log -Wait -AdditionalArguments "-verbose -nographics -manualLicenseFile $env:TMP\Unity_lic.ulf"

Start-UnityEditor -Project $pwd\HandAssemblyPlanning -ExecuteMethod NugetForUnity.NugetHelper.Restore -BatchMode -Quit -Wait -LogFile $pwd\Logs\NuGet.log -AdditionalArguments "-verbose -nographics -ignoreCompilerErrors"
Start-UnityEditor -Project $pwd\HandAssemblyPlanning -ExecuteMethod Microsoft.MixedReality.Toolkit.Build.Editor.UnityPlayerBuildTools.StartCommandLineBuild -BuildTarget WSAPlayer -BatchMode -Quit -LogFile $pwd\Logs\Build.log -Wait -AdditionalArguments "-verbose -nographics -logDirectory Logs -arm64" -Verbose


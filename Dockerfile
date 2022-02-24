FROM mcr.microsoft.com/powershell:lts-nanoserver-ltsc2022

USER ContainerAdministrator
#ADD https://aka.ms/vs/16/release/vc_redist.x64.exe C:/Downloads/vcredist_x64.exe
#RUN C:\Downloads\vcredist_x64.exe /install /passive /norestart /log out.txt

# Configure shell
SHELL ["pwsh", "-Command"]

# Install UnitySetup
RUN Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
RUN Install-Module -Name UnitySetup -AllowPrerelease -skippublishercheck -Scope AllUsers

#################
# Install Unity #
#################

ARG version
ENV UNITY_EDITOR_VER=$version
RUN Install-UnitySetupInstance -Installers (Find-UnitySetupInstaller -Version ${version} -Components 'Windows','Windows_IL2CPP','UWP_IL2CPP') -Verbose

USER ContainerUser
COPY ./common /common

# Default commands to pwsh
ENTRYPOINT ["pwsh","-c"]

FROM rancher.med.osd.ds:5000/dotnet:redhat

USER root

COPY file/nuget-cleanup.sh /opt/

WORKDIR /src
COPY ["/src/DHA.Ektropy.Web/DHA.Ektropy.Web.csproj", "DHA.Ektropy.Web/"]
RUN dotnet restore "DHA.Ektropy.Web/DHA.Ektropy.Web.csproj" && sh /opt/nuget-cleanup.sh
COPY ./src .
WORKDIR "/src/DHA.Ektropy.Web"
RUN dotnet build "DHA.Ektropy.Web.csproj" -c Release -o /opt/app-root/ && dotnet publish "DHA.Ektropy.Web.csproj" -c Release -o /opt/app-root/ && sh /opt/nuget-cleanup.sh

RUN chown root /src -R && chown 1001.1001 /opt/app-root/ -R 

USER 1001
ENV ASPNETCORE_URLS='http://*:8080'

ENV CONTAINER_SCRIPTS_PATH=/opt/app-root/
ENV DOTNET_DEFAULT_CMD=default-cmd.sh

ENV NUGET_XMLDOC_MODE=skip
ENV EKTROPY_BUILD=${BUILD_ID}
ENV HOME=/opt/app-root/
ENV DOTNET_CORE_VERSION=3.1

ENV EKTROPY_WEB_SERVICE_PORT_EKTROPY_HTTP=8080
ENV DOTNET_USE_POLLING_FILE_WATCHER=true
ENV DOTNET_APP_PATH=/opt/app-root/

WORKDIR /opt/app-root/


ENTRYPOINT ["dotnet", "DHA.Ektropy.Web.dll"]

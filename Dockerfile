FROM rancher.med.osd.ds:5000/dotnetcore-sdk-3.1:latest

USER root

WORKDIR /src
COPY ["DHA.Ektropy.Web/DHA.Ektropy.Web.csproj", "DHA.Ektropy.Web/"]
RUN dotnet restore "DHA.Ektropy.Web/DHA.Ektropy.Web.csproj"
COPY . .
WORKDIR "/src/DHA.Ektropy.Web"
RUN dotnet build "DHA.Ektropy.Web.csproj" -c Release -o /app

RUN dotnet publish "DHA.Ektropy.Web.csproj" -c Release -o /app

WORKDIR /app

ENTRYPOINT ["dotnet", "DHA.Ektropy.Web.dll"]


RUN chown root /src -R


RUN chown dotnet.dotnet /app -R

USER dotnet
ENV ASPNETCORE_URLS='http://*:8080'

ENV CONTAINER_SCRIPTS_PATH=/app
ENV DOTNET_DEFAULT_CMD=default-cmd.sh
ENV ASPNETCORE_URLS=http://*:8080
ENV NUGET_XMLDOC_MODE=skip

ENV HOME=/app
ENV DOTNET_CORE_VERSION=3.1

ENV EKTROPY_WEB_SERVICE_PORT_EKTROPY_HTTP=8080
ENV DOTNET_USE_POLLING_FILE_WATCHER=true
ENV DOTNET_APP_PATH=/app/

WORKDIR /app


ENTRYPOINT ["dotnet", "DHA.Ektropy.Web.dll"]

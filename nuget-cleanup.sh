DOTNET_INCREMENTAL="${DOTNET_INCREMENTAL:-false}"
if [ "$DOTNET_INCREMENTAL" == "true" ]; then
  mkdir /opt/app-root/packages-for-incremental-build
  find /root/.nuget/packages -type f -maxdepth 3 -name '*.nupkg' -exec mv -t /opt/app-root/packages-for-incremental-build {} \+
fi
rm -rf /root/{.nuget,.local}

if [ "$DOTNET_RM_SRC" == "true" ]; then
  echo "---> Removing sources..."
  rm -rf /src/*
fi

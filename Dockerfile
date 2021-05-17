FROM rancher.med.osd.ds:5000/ubi8/dotnet-31:latest

RUN /dotnet-install.sh -i /opt/app-root/.dotnet/ &&  /dotnet-install.sh -i /usr/lib64/dotnet/ 
COPY ./src /tmp/src
RUN chown -R 1001:0 /tmp/src && chown -R 1001:0 /opt/app-root/ -R
USER 1001

ENV DOTNET_STARTUP_PROJECT=DHA.Ektropy.Web/DHA.Ektropy.Web.csproj

RUN /usr/libexec/s2i/assemble 
CMD /usr/libexec/s2i/run

﻿FROM mcr.microsoft.com/dotnet/sdk:7.0 as build-env

WORKDIR /app
COPY . ./
RUN dotnet publish ./Bomcop/Bomcop.csproj -c Release -o out -p:PublishSingleFile=false -p:PublishTrimmed=false

LABEL maintainer="Samuel Massé <samuelmasse4@gmail.com>"
LABEL repository="https://github.com/samuelmasse/bomcop"
LABEL homepage="https://github.com/samuelmasse/bomcop"

LABEL com.github.actions.name="Bomcop"
LABEL com.github.actions.description="A tool to verify all your files contain an UTF-8 BOM"
LABEL com.github.actions.icon="activity"
LABEL com.github.actions.color="orange"

FROM mcr.microsoft.com/dotnet/sdk:7.0
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet", "/bomcop.dll" ]
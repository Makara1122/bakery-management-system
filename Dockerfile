# Use the official .NET runtime image as a base
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Use the official .NET SDK image for building the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["bakery-management-system.csproj", "./"]
RUN dotnet restore "./bakery-management-system.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet publish "bakery-management-system.csproj" -c Release -o /app/publish

# Final stage: runtime image
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "bakery-management-system.dll"]

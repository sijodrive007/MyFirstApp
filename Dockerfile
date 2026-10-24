
# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY ["MyFirstApp.csproj", "./"]
RUN dotnet restore "MyFirstApp.csproj"

COPY . .
RUN dotnet publish "MyFirstApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 2: Run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MyFirstApp.dll"]

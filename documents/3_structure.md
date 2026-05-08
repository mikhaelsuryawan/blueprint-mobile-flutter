# Structure
This is the directory structure of the blueprint
```text
--- Config
------ Routes
------ Themes
--- Constants
--- Models
------ [Profile]
-------- Request
-------- Response
--- Modules
------ Core
------ Main
--- Repositories
--- Utils
------ Service
--- Widgets
```

## Config
This folder is for configuring a project

### Routes
This folder is for configuring a project

### Themes
This folder for theme setting

## Constants
This folder contains the constant class in the application. Preferably using an existing file.

## Models
Contains the models class used in the application which is divided into 2 folders,  `Request`  and  `Response`.

### Request
Models data class when requesting to  `API`.

### Response
Models data class when getting response from  `API`.

## Modules
This folder contains the main modules in the application which are divided into 2 folders such as `Core`, and  `Main`.

### Core
This folder contains modules  `Before`  the user enters the application, such as  `Login`  page,  `Register`  page, and  `Forgot Password`  page.

### Main

This folder contains modules  `After`  the user enters the application such as  `Home`  page,  `Profile`  page.

## Repositories
This folder contains  `Repository`  class for communicate between  `BLOC`  and  `HttpClient`  to call API.

## Utils
This folder contains  `Utility`  class or  `Helper`  class.

### Services
This folder is for setting the service of a project

## Widgets
This folder is used to store widgets that are used many times

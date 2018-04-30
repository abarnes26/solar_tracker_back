# Solar Carbon Tracker - Back End
## (Turing Capstone)

## Goal of this Project
- Build an API that will serve solar data to the front end
- Incorporate NREL and Google Maps API along side Ruby to perform complex energy calculations
- Users can access data relating to business intelligence and basic model relationships.
- All endpoints will return JSON data
- All endpoints should be exposed under an api and version (v1) namespace (e.g. /api/v1/branches/1/vehicles)

## Getting Started
To get started, clone down this reposotory and run the following command - 
```
bundle
```
from the command line.  Once the folder is bundled run the following command - 
```
rails db:setup
```

### Testing

This project has it's own internal set of tests to maintain structure and functionality. Once you have set up your database, these tests can be accessed by running the following command -

```
rspec
```

## An Overview of the data relationships

The database relationships in this project represent those of a typical solar energy installation business. The Branch is the basis for most of the relationships, allowing the user to add PV Modules, Vehicles, and Projects to the Branch. The schema illustrating these relationships can be found below -

![alt text](https://i.imgur.com/JMi9ziV.jpg)

## Sample API Queries

### Relationship Endpoints

#### Branches

```POST /api/v1/branches/``` creates a branch with the required information (see schema above)

```GET /api/v1/branches/``` returns a collection of all branches in the database

```GET /api/v1/branches/:id``` returns information for a single branch with the given id

```PATCH /api/v1/branches/:id``` updates specified attribute of a single branch with the given id

```DELETE /api/v1/branches/:id``` removes a single branch with the given id


#### PV Modules

```POST /api/v1/branches/:id/pv_modules``` creates a pv_module with the required information (see schema above) and adds it to the branch with the given id.

```GET /api/v1/branches/:id/pv_modules``` returns a collection of all PV Modules associated with the given branch

```GET /api/v1/branches/:id/pv_modules/:id``` returns information for a single Pv Module with given id

```PATCH /api/v1/branches/:id/pv_modules/:id``` updates specified attribute of a single Pv Module with the given id

```DELETE /api/v1/branches/:id/pv_module/:id``` removes a single pv module from the database


#### Vehicles

```POST /api/v1/branches/:id/vehicles``` creates a vehicle with the required information (see schema above) and adds it to the branch with the given id.

```GET /api/v1/branches/:id/vehicles``` returns a collection of all vehicles associated with the given branch

```GET /api/v1/branches/:id/vehicles/:id``` returns information for a single vehicle with given id

```PATCH /api/v1/branches/:id/vehicles/:id``` updates specified attribute of a single vehicle with the given id

```DELETE /api/v1/branches/:id/vehicles/:id``` removes a single vehicle from the database

#### Vehicles

```POST /api/v1/branches/:id/vehicles``` creates a vehicle with the required information (see schema above) and adds it to the branch with the given id.

```GET /api/v1/branches/:id/vehicles``` returns a collection of all vehicles associated with the given branch

```GET /api/v1/branches/:id/vehicles/:id``` returns information for a single vehicle with given id

```PATCH /api/v1/branches/:id/vehicles/:id``` updates specified attribute of a single vehicle with the given id

```DELETE /api/v1/branches/:id/vehicles/:id``` removes a single vehicle from the database

#### Projects

```POST /api/v1/branches/:id/projects``` creates a project with the required information (see schema above) and adds it to the branch with the given id.

```GET /api/v1/branches/:id/projects``` returns a collection of all projects associated with the given branch

```GET /api/v1/branches/:id/projects/:id``` returns information for a single project with given id

```PATCH /api/v1/branches/:id/projects/:id``` updates specified attribute of a single project with the given id

```DELETE /api/v1/branches/:id/projects/:id``` removes a single project from the database


## Credits
Built with Ruby on Rails and PostgreSQL by Alex Barnes




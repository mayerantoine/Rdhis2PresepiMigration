# Populate dhis2 tracker with data from legacy Sentinel Surveillance
This project to goal is to migrate data from legacy PRESEPI MS Access Database to DHIS2 Tracker using R.

### LABORATORY-ENHANCED SENTINEL SURVEILLANCE (PRESEPI)

Sentinel surveillance collecting samples for different syndromes in selected hopitals in the country with laboratory test results centralize. All data were collected and stored in an MS Access database.

### DHIS2 Tracker

The DHIS 2 Tracker is an extension of the DHIS 2 platform and supports management, data collection, and analysis of transactional or disaggregated data.It lets you store information about individuals and track these persons over time using a flexible set of identifiers.The Tracker shares the same design concepts as the overall DHIS 2 - a combination of a generic data model and flexible metadata configuration through the user interface that allows for rapid customization to meet a wide range of use cases.

The DHIS2 Web API is a component which makes it possible for external systems to access and manipulate data stored in an instance of DHIS2. More precisely, it provides a programmatic interface to a wide range of exposed data and service methods for applications such as third-party software clients, web portals and internal DHIS2 modules

### Our Solutions using R

1. We create a function which combine the data from the source systems and metadata from DHIS2  to generate a json file by facilities.
2. We create a  second function to process a each json file split by year-month to populate DHIS2 Tracker using the Web API


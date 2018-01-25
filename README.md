# Driving History

## Setting up the project
To set up the project run `bundle`

## Running the tests
To run the unit tests, run `rake`

## Running the project
To run the project, run `ruby lib/driving_history datafile` where `datafile` is the name of a file containing properly formatted input data

## Assumptions
For the sake of following the prompt and keeping the code simple, a number of assumptions were made. This falls under the general philosophy of design by contract, with a heavy focus in not building behavior where none is asked for. The consequence of this is that breaking these rules will result in undefined behavior. This sounds unacceptable at first, but it becomes acceptable when the module under contract is imagined as part of a larger project that ensures these assumptions are true before allowing this code to run. This is a subset of those assumptions:

* The command line argument for the data file points to a file that can be found
* The data file that is passed to the program is non-empty
* The data file does not reference trips by drivers before those drivers are registered
* The driver names within the data file are distinct
* The data file is not so large that it cannot be loaded into memory
* Each line in the data file starts with a valid command
* Each line in the data file is properly formatted and ends with a newline
* Data is considered improperly formatted if the start time is not before the end time, or if midnight is passed

## Design decisions
* Objects were chosen to represent the data for a variety of reasons. The big picture answer for why this is boils down to the idea that the problem domain seems simplest to model with objects. Additionally, objects allow the developer to slowly build up a model over the runtime of the program and then decide how the output will be formatted at the end. Admittedly, structs or even hashes could be used to aggregate data but building models will enable more extensibility in the long term. An example of this idea could be adding a new type of object such as a car. If cars have to be tracked, this may not fit well into the structure of hashes or structs that are being built up. On the other hand, adding a car class and then notifying it of data that is relevant to it should be simple, and should not necessitate large changes to the driver or trip abstractions. Changes to output format should be easy as well.
* Isolation testing is used in order to make it so that if there is a break in functionality in one place, that break will be exposed by one failing unit test, rather than by unit tests failing in any place that object is referenced. This style of testing also lends itself well to driving in the new functionality of the application by making assumptions about what is required of a collaborator, but leaving the details of how this is accomplished for later. Then, when it is time to create those collaborators, the contract under which they must perform is well defined.
* Difficult to test parts of the code such as taking command line input are isolated in wrappers. This increases complexity somewhat but makes it easy to test any objects that collaborate with these wrappers. The wrappers themselves are as simple as possible to limit the risk of a defect in this code that is not under unit test

# Driving History

## Setting up the project
To set up the project run `bundle`

## Running the tests
  * To run the unit tests, run `rake`
  * To run the acceptance test, run `rake acceptance`


## Running the project
To run the project, run `ruby run.rb datafile` where `datafile` is the name of a file containing properly formatted input data

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
* The design of the acceptance test had a few false starts, and ended up a but unusual as a result. Originally, the acceptance test was going to be written only in bash, as the interface is on the command line. This presented a problem, as a failure output produced by a bash echo seemed easy to miss. Therefore, as much as practical was kept in bash, with the determination of whether the test passed being left to ruby. This had an advantage of being easily integrated into rake, and also leaves a place for further tests at this level.
* The decision to create a model abstraction was a difficult one. Originally, driving history was going to call a parser and then use the output to build collections of drivers and trips. There were some issues with this approach. The role of a theoretical parser did not become clear without that parser having the capability to return driver and trip objects. If this approach were taken, there would not be a unified interface for building models, and changes in report generation as a result of adding or changing models would be visible in driving history. The model serves as a facade, so that driving history is safe from model updates and can be concerned only with opening the correct file and asking for a model to be built. At first, model seems to have a dual responsibility to training and reporting (these are its public methods after all) but ultimately it is concerned with processing input text into an abstract domain, and also processing an existing abstract domain into a serial output. Therefore this can be viewed as a single (though large) responsibility to serve as a translator into and out of the domain.
* Isolation testing is used in order to make it so that if there is a break in functionality in one place, that break will be exposed by one failing unit test, rather than by unit tests failing in any place that object is referenced. This style of testing also lends itself well to driving in the new functionality of the application by making assumptions about what is required of a collaborator, but leaving the details of how this is accomplished for later. Then, when it is time to create those collaborators, the contract under which they must perform is well defined. The downside to this approach is that the integration testing is left for much later and issues can crop up at this stage. In this particular instance, running acceptance tests revealed a few small issues including missing include statements, a problem with splitting on single quoted carriage returns, and a math error in the code that finds average speed.
* Difficult to test parts of the code such as taking command line input are isolated in wrappers. This increases complexity somewhat but makes it easy to test any objects that collaborate with these wrappers. The wrappers themselves are as simple as possible to limit the risk of a defect in this code that is not under unit test.

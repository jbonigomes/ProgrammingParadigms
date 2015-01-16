# Temperature Converter with Erlang

### Purposes of this assignment

- To familiarise you with the syntax of Erlang.
- To familiarise you with the more important concurrent features of the
language.

### General

Write a message passing program that can perform temperature conversions.

### Detail

Your program should consist of a temperature converter actor, a display actor,
and a controller actor. The temperature converter actor should respond to two
types of message:

1. If sent a `ConvertToCelsius` message with a temperature in degrees Fahrenheit
as an argument, it should send a Temperature message containing the temperature
in Fahrenheit and the equivalent temperature in Celsius to the display actor.
1. If sent a `ConvertToFahrenheit` message with a temperature in degrees Celsius
as an argument, it should send a Temperature message containing the temperature
in Celsius and the equivalent temperature in Fahrenheit to the display actor.

### Conversion:
- A temperature in Fahrenheit can be converted to Celsius by subtracting 32 then
multiplying by 5/9.
- A temperature in Celsius can be converted to Fahrenheit by multiplying by 9/5
then adding 32.

The controller actor should send several `ConvertToCelsius` and
`ConvertToFahrenheit` messages to the temperature converter actor to test its
behaviour. The display actor should wait for Temperature messages, and print out
the temperate in both Fahrenheit and Celsius (your program does not need a fancy
user interface, simple textual output is sufficient). The three actors therefore
pass messages between themselves in a pipeline, as shown below:

		Controller Actor =⇒ Temperature Convertor Actor =⇒ Display Actor

The actors may need to be driven by some form of main program, depending on the
message passing system used; you should write whatever supporting infrastructure
is needed.

### Credits

Thanks to Dr. Colin Perkins, at the School of Computing Science, University of
Glasgow, for the basis of this coursework assignment.

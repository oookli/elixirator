# Rocket Fuel Calculator

This is a command-line application that calculates the amount of fuel required for a given spaceflight mission. The program uses the mass of the spacecraft and the flight path to determine the total fuel needed.

## Usage

### Installation

1. Clone this repository to your local machine.

   ```
   git clone https://github.com/oookli/elixirator.git
   ```

2. Navigate to the project directory.

   ```
   cd elixirator
   ```

### Running the Program

To calculate the fuel required for a mission, run the `rocket_fuel_calculator` script with the following command:

```
./bin/fuel_calculator <mass> <path>
```

Replace `<mass>` with the mass of the spacecraft in kilograms and `<path>` with the flight path in the format `launch earth land moon launch moon land earth ...`.

The flight path should be provided as a list of tuples, where each tuple contains an action (`launch` or `land`) and a target planet (`earth`, `moon`, or `mars`).

#### Example

```
./bin/fuel_calculator 28801 launch earth land moon launch moon land earth
```

This will calculate the total fuel required for the specified mission.

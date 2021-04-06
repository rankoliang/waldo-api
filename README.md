# Where's Waldo API

This is the api for the Where's Waldo app hosted at https://waldo.rankoliang.com/.

The frontend repository for this application can be found at https://github.com/rankoliang/waldo-frontend/.

## How to Play

- Select a level from the homepage.
- Click the image where you see one of the characters.
- Select the character from the dropdown menu
- Repeat until you have found all of the characters for a level.
- Submit your score!

## Setup

You will need to clone the frontend repository linked again [here](https://github.com/rankoliang/waldo-frontend/).
Also, set up the environment variables at `dev.env` according to the variables in `dev.env.sample` in the repository
you are running `docker-compose` from.

This application uses docker to run.

To set up your development environment, you must have
[docker](https://docs.docker.com/get-docker/) and [docker-compose](https://docs.docker.com/compose/install/) installed.

There is a `bin/dc` script to run docker-compose with the appropriate configurations depending on your environment.
There is also a Makefile available where you can run some preselected commands.

With a `-p` flag, you will run the commands for production and without it, you will run the commands in development mode.

To build the docker containers, run `make build` or `bin/dc build`.

To run the docker containers, run `make up` or `bin/dc up -d`.

See the respective files for more options.

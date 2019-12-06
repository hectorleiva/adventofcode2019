const fs = require('fs'),
  readline = require('readline');

let lastXPos = 0;
let lastYPos = 0;

const wireA = new Set();
const wireB = new Set();

const rd = readline.createInterface({
  input: fs.createReadStream('./03.input'),
  console: false
});

const total_directions = [];
rd.on('line', (line) => {
  total_directions.push(line.split(','));
});

rd.on('close', () => {
  total_directions.forEach((directions, index) => {
    lastXPos = 0;
    lastYPos = 0;

    directions.forEach((direction) => {
      assignWireValues(direction, index)
    });
  });

  const matches = [];
  wireA.forEach((cord1) => {
    wireB.forEach((cord2) => {
      if(doCoordinatesMatch(cord1, cord2)) {
        matches.push(cord1);
      }
    });
  });

  const sortedMatches = matches.sort((matchA, matchB) => {
    const distanceA = manhattanDistanceCalc(matchA[0], matchA[1]);
    const distanceB = manhattanDistanceCalc(matchB[0], matchB[1]);

    return distanceA - distanceB;
  });

  const shortestDistance = manhattanDistanceCalc(sortedMatches[0][0], sortedMatches[0][1]);

  console.log('coordinates with the shortest distance: ', sortedMatches[0], shortestDistance);
});

function manhattanDistanceCalc(xPos, yPos) {
  return Math.abs(xPos) + Math.abs(yPos);
}

function doCoordinatesMatch(arr1, arr2) {
  return (arr1[0] == arr2[0]) && (arr1[1] == arr2[1]);
}

function assignWireValues(direction, index) {
  if (index == 0) {
    directionCalculator(direction, wireA);
  } else if (index == 1) {
    directionCalculator(direction, wireB);
  }
}

function directionCalculator(direction, wire) {
  movement = direction.slice(0,1);
  distance = Number(direction.slice(1));

  switch(movement) {
    case 'U':
      for (let i=1; i <= distance; i++) {
        wire.add([lastXPos, lastYPos + i]);
      }

      lastYPos = lastYPos + distance;
      break;
    case 'D':
      for (let i=1; i <= distance; i++) {
        wire.add([lastXPos, lastYPos - i]);
      }

      lastYPos = lastYPos - distance;
      break;
    case 'L':
      for (let i=1; i <= distance; i++) {
        wire.add([lastXPos - i, lastYPos]);
      }

      lastXPos = lastXPos - distance;
      break;
    case 'R':
      for (let i=1; i <= distance; i++) {
        wire.add([lastXPos + i, lastYPos]);
      }

      lastXPos = lastXPos + distance;
      break;
  }
}

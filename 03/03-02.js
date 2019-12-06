const fs = require('fs'),
  readline = require('readline');

let lastXPos = 0;
let lastYPos = 0;

const wireA = [];
const wireB = [];

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

  const stepsForMatches = [];
  wireA.forEach((cord1, index) => {
    wireB.forEach((cord2, indx) => {
      if(doCoordinatesMatch(cord1, cord2)) {
        const totalSteps = (index + 1) + (indx + 1);
        stepsForMatches.push(totalSteps);
      }
    });
  });

  const sortedSteps = stepsForMatches.sort((stepsA, stepsB) => {
    return stepsA - stepsB;
  });

  console.log('fewest combined steps for wires to reach an intersection: ', sortedSteps[0]);
});

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
        wire.push([lastXPos, lastYPos + i]);
      }

      lastYPos = lastYPos + distance;
      break;
    case 'D':
      for (let i=1; i <= distance; i++) {
        wire.push([lastXPos, lastYPos - i]);
      }

      lastYPos = lastYPos - distance;
      break;
    case 'L':
      for (let i=1; i <= distance; i++) {
        wire.push([lastXPos - i, lastYPos]);
      }

      lastXPos = lastXPos - distance;
      break;
    case 'R':
      for (let i=1; i <= distance; i++) {
        wire.push([lastXPos + i, lastYPos]);
      }

      lastXPos = lastXPos + distance;
      break;
  }
}

import { dynamicColor, generateDatasets, normalizeLabels } from "./chart_helper";

$(()=> {
  Array.from(document.getElementsByClassName('single_option-chart')).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let datasets = JSON.parse(chart.canvas.dataset.data);
    simpleBarsChart(chart, datasets[0]);
  });

  Array.from(document.getElementsByClassName('multiple_option-chart')).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let datasets = JSON.parse(chart.canvas.dataset.data);
    simpleBarsChart(chart, datasets);
  });

  Array.from(document.getElementsByClassName('matrix_multiple-chart')).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let datasets = JSON.parse(chart.canvas.dataset.data);
    renderMatrixChart(chart, datasets);
  });

  Array.from(document.getElementsByClassName('matrix_single-chart')).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let datasets = JSON.parse(chart.canvas.dataset.data);
    renderMatrixChart(chart, datasets);
  });
});

function renderMatrixChart(ctx, datasets) {
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: normalizeLabels(JSON.parse(ctx.canvas.dataset.labels)),
      datasets: datasets
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            stepSize: 1
          }
        }
      }
    }
  });
}

function simpleBarsChart(ctx, dataset) {
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: normalizeLabels(JSON.parse(ctx.canvas.dataset.labels)),
      datasets: [{
        label: 'Number of Votes',
        data: dataset['data'],
        backgroundColor: dynamicColor(),
        borderWidth: 1,
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            stepSize: 1
          }
        }
      }
    }
  });
}

function multipleBarsChart(ctx, data) {
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: normalizeLabels(JSON.parse(ctx.canvas.dataset.labels)),
      datasets: generateDatasets(data)
    },
    options: {
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            stepSize: 1
          }
        }
      }
    }
  });
}
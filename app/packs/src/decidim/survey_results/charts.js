import { normalizeLabels } from "./chart_helper";

$(()=> {
  Array.from(document.getElementsByClassName('short_answer-chart')).concat(
    Array.from(document.getElementsByClassName('long_answer-chart')).concat(
      Array.from(document.getElementsByClassName('files-chart'))
      )
  ).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let dataset = JSON.parse(chart.canvas.dataset.dataset);
    renderPieChart(chart, dataset);
  });

  Array.from(document.getElementsByClassName('single_option-chart')).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let datasets = JSON.parse(chart.canvas.dataset.datasets);
    simpleBarsChart(chart, datasets[0]);
  });

  Array.from(document.getElementsByClassName('multiple_option-chart')).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let datasets = JSON.parse(chart.canvas.dataset.datasets);
    simpleBarsChart(chart, datasets[0]);
  });

  Array.from(document.getElementsByClassName('matrix_multiple-chart')).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let datasets = JSON.parse(chart.canvas.dataset.datasets);
    renderMatrixChart(chart, datasets);
  });

  Array.from(document.getElementsByClassName('matrix_single-chart')).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let datasets = JSON.parse(chart.canvas.dataset.datasets);
    renderMatrixChart(chart, datasets);
  });

  Array.from(document.getElementsByClassName('sorting-chart')).forEach(canvas => {
    let chart = canvas.getContext('2d');
    let datasets = JSON.parse(chart.canvas.dataset.datasets);
    renderLinesChart(chart, datasets);
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
        label: dataset['label'],
        data: dataset['data'],
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

function renderPieChart(ctx, dataset) {
  new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: normalizeLabels(JSON.parse(ctx.canvas.dataset.labels)),
      datasets: [dataset]
    }
  });
}

function renderLinesChart(ctx, datasets) {
  new Chart(ctx, {
    type: 'line',
    data: {
      labels: normalizeLabels(JSON.parse(ctx.canvas.dataset.labels)),
      datasets: datasets
    }
  });
}

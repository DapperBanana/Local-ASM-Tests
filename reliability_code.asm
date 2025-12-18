using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using OxyPlot;
using OxyPlot.Series;
using OxyPlot.WindowsForms;

class Program
{
    static void Main()
    {
        string csvPath = "data.csv"; // Path to your CSV file

        // Read the CSV data
        var data = File.ReadAllLines(csvPath)
                       .Skip(1) // Skip header if present
                       .Select(line => {
                           var parts = line.Split(',');
                           return new {
                               Label = parts[0],
                               Value = double.Parse(parts[1])
                           };
                       }).ToList();

        // Create a bar series
        var barSeries = new ColumnSeries
        {
            Title = "Data",
            StrokeColor = OxyColors.Black,
            StrokeThickness = 1
        };

        var categoryAxis = new OxyPlot.Axes.CategoryAxis { Position = OxyPlot.Axes.AxisPosition.Bottom };
        var valueAxis = new OxyPlot.Axes.LinearAxis { Position = OxyPlot.Axes.AxisPosition.Left, MinimumPadding = 0, AbsoluteMinimum = 0 };

        foreach (var item in data)
        {
            barSeries.Items.Add(new ColumnItem(item.Value));
            categoryAxis.Labels.Add(item.Label);
        }

        // Create the plot model
        var model = new PlotModel { Title = "Bar Chart from CSV Data" };
        model.Series.Add(barSeries);
        model.Axes.Add(categoryAxis);
        model.Axes.Add(valueAxis);

        // Display the plot in a Windows Form
        var plotView = new PlotView { Dock = System.Windows.Forms.DockStyle.Fill, Model = model };
        var form = new System.Windows.Forms.Form
        {
            Width = 800,
            Height = 600,
            Text = "Bar Chart"
        };
        form.Controls.Add(plotView);
        System.Windows.Forms.Application.Run(form);
    }
}
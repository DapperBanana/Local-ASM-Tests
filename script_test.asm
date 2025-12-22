using System;
using System.Collections.Generic;
using System.IO;
using OxyPlot;
using OxyPlot.Series;
using OxyPlot.WindowsForms;

class Program
{
    static void Main()
    {
        // Read data from CSV file
        var data = new List<(string Label, double Value)>();
        using (var reader = new StreamReader("data.csv"))
        {
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                // Assuming CSV format: label,value
                var parts = line.Split(',');
                if (parts.Length == 2 && double.TryParse(parts[1], out double val))
                {
                    data.Add((parts[0], val));
                }
            }
        }

        // Create a plot model
        var plotModel = new PlotModel { Title = "Bar Chart" };
        var series = new ColumnSeries();

        foreach (var item in data)
        {
            series.Items.Add(new ColumnItem { Value = item.Value });
        }

        plotModel.Series.Add(series);
        // For displaying labels, you might add CategoryAxis, etc.

        // Display the plot in a window
        var plotView = new PlotView { Model = plotModel, Dock = System.Windows.Forms.DockStyle.Fill };
        var form = new System.Windows.Forms.Form
        {
            Width = 800,
            Height = 600
        };
        form.Controls.Add(plotView);
        System.Windows.Forms.Application.Run(form);
    }
}
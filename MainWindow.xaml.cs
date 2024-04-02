using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using MySql.Data.MySqlClient;
using ScottPlot;
using System.Windows.Markup;

namespace LR4_bbiad
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        class Database
        {
            MySqlConnection connection = new MySqlConnection("Server=127.0.0.1; Database=var4; User ID=root; Password=root");
            public void openConnection()
            {
                if (connection.State == System.Data.ConnectionState.Closed)
                    connection.Open();
            }
            public void closeConnection()
            {
                if (connection.State == System.Data.ConnectionState.Open)
                    connection.Close();
            }
            public MySqlConnection GetConnection()
            {
                return connection;
            }
        }

        private Database DB;
        private DataTable table1, table2, table3, table4;
        private MySqlDataAdapter adapter;
        private BitmapImage bi3;

        public MainWindow()
        {
            InitializeComponent();
            DB = new Database();
            table1 = new DataTable();
            table2 = new DataTable();
            table3 = new DataTable();
            table4 = new DataTable();
            adapter = new MySqlDataAdapter();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            DB.openConnection();
            MySqlCommand command;

            DataTable dt2 = new DataTable();
            command = new MySqlCommand("select название from var4.станки;", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(dt2);
            foreach (DataRow row in dt2.Rows)
            {
                название_станка.Items.Add((string)(row.ItemArray[0]));
            }

            DataTable dt3 = new DataTable();
            command = new MySqlCommand("select `для оси` from var4.приводы;", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(dt3);
            foreach (DataRow row in dt3.Rows)
            {
                состояние_привода.Items.Add((string)(row.ItemArray[0]));
            }


            DB.closeConnection();

            bi3 = new BitmapImage();
            bi3.BeginInit();
            bi3.UriSource = new Uri("Resources/lock.png", UriKind.Relative);
            изображение_станка.Source = bi3;
            bi3.EndInit();
            zero_zindex();
            Panel.SetZIndex(заглушка, 1);   //изначально заглушка поверх всех окон
            //Panel.SetZIndex(заглушка_графика, 1);
        }

        private void zero_zindex()
        {
            Panel.SetZIndex(заглушка, 0);
            //Panel.SetZIndex(заглушка_графика, 0);
            Panel.SetZIndex(таблица_двигатели, 0);
            Panel.SetZIndex(таблица_активные_сообщения, 0);
            Panel.SetZIndex(таблица_оси_главного_движения, 0);
            Panel.SetZIndex(таблица_оси_движения_фрезерной_головы, 0);
        }

        private void тип_станка_DropDownClosed(object sender, EventArgs e)
        {
            bi3 = new BitmapImage();
            bi3.BeginInit();

            if (тип_станка.Text == "Станок с ЧПУ токарного типа с дополнительной фрезерной головой")
            {
                название_станка.IsEnabled = true;
                bi3.UriSource = new Uri("Resources/def.png", UriKind.Relative);
                изображение_станка.Source = bi3;
                label1.Content = "Станок не выбран...";
            }
            else
            {
                название_станка.IsEnabled = false;
                bi3.UriSource = new Uri("Resources/lock.png", UriKind.Relative);
                изображение_станка.Source = bi3;
            }
            if (тип_станка.Text != "Станок с ЧПУ токарного типа с дополнительной фрезерной головой" && название_станка.Text != "Выберите название станка...")
                label1.Content = "Станок подходящего типа не выбран...";

            bi3.EndInit();
        }

        private void название_станка_DropDownClosed(object sender, EventArgs e)
        {
            bi3 = new BitmapImage();
            bi3.BeginInit();

            switch (название_станка.Text)
            {
                case "SPECTR TC":
                    bi3.UriSource = new Uri("Resources/1.png", UriKind.Relative);
                    изображение_станка.Source = bi3;
                    break;
                case "SPECTR G5-Y":
                    bi3.UriSource = new Uri("Resources/2.png", UriKind.Relative);
                    изображение_станка.Source = bi3;
                    break;
                case "IRONMAC ITX-65M/1250":
                    bi3.UriSource = new Uri("Resources/3.png", UriKind.Relative);
                    изображение_станка.Source = bi3;
                    break;
                default:
                    bi3.UriSource = new Uri("Resources/def.png", UriKind.Relative);
                    изображение_станка.Source = bi3;
                    break;
            }

            DB.openConnection();
            MySqlCommand command;
            DataTable dt = new DataTable();
            command = new MySqlCommand("select тип from var4.станки where название = \"" + название_станка.Text + "\";", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(dt);
            DataRow row = dt.Rows[0];                                               //так как результат селекта это одна строка, то используем индекс массива 0, другие индексы вызывают исключение
            label1.Content = название_станка.Text + " - " + (string)(row.ItemArray[0]);      //так как результат селекта это одна строка, то используем индекс массива 0, другие индексы вызывают исключение
            DB.closeConnection();

            bi3.EndInit();
        }

        private void состояние_привода_DropDownClosed(object sender, EventArgs e)
        {
            bi3 = new BitmapImage();
            bi3.BeginInit();

            DB.openConnection();
            MySqlCommand command;
            DataTable dt = new DataTable();
            DataRow row;

            switch (состояние_привода.Text)
            {
                case "Ось X'":
                    command = new MySqlCommand("select состояние from var4.приводы where `для оси` = \"Ось X\'\";", DB.GetConnection());
                    adapter.SelectCommand = command;
                    adapter.Fill(dt);
                    row = dt.Rows[0];

                    ChechState();
                    break;

                case "Ось Z'":
                    command = new MySqlCommand("select состояние from var4.приводы where `для оси` = \"Ось Z\'\";", DB.GetConnection());
                    adapter.SelectCommand = command;
                    adapter.Fill(dt);
                    row = dt.Rows[0];

                    ChechState();
                    break;

                case "Ось C'":
                    command = new MySqlCommand("select состояние from var4.приводы where `для оси` = \"Ось C\'\";", DB.GetConnection());
                    adapter.SelectCommand = command;
                    adapter.Fill(dt);
                    row = dt.Rows[0];

                    ChechState();
                    break;

                case "Ось X":
                    command = new MySqlCommand("select состояние from var4.приводы where `для оси` = \"Ось X\";", DB.GetConnection());
                    adapter.SelectCommand = command;
                    adapter.Fill(dt);
                    row = dt.Rows[0];

                    ChechState();
                    break;
                case "Ось Y":
                    command = new MySqlCommand("select состояние from var4.приводы where `для оси` = \"Ось Y\";", DB.GetConnection());
                    adapter.SelectCommand = command;
                    adapter.Fill(dt);
                    row = dt.Rows[0];

                    ChechState();
                    break;
                case "Ось Z":
                    command = new MySqlCommand("select состояние from var4.приводы where `для оси` = \"Ось Z\";", DB.GetConnection());
                    adapter.SelectCommand = command;
                    adapter.Fill(dt);
                    row = dt.Rows[0];

                    ChechState();
                    break;
                case "Ось C":
                    command = new MySqlCommand("select состояние from var4.приводы where `для оси` = \"Ось C\";", DB.GetConnection());
                    adapter.SelectCommand = command;
                    adapter.Fill(dt);
                    row = dt.Rows[0];

                    ChechState();
                    break;
                default:
                    bi3.UriSource = new Uri("Resources/grey light.png", UriKind.Relative);
                    лампочка_готовности.Source = bi3;
                    break;
            }
            
            void ChechState()
            {
                if ((string)(row.ItemArray[0]) == "Готов")
                {
                    bi3.UriSource = new Uri("Resources/gl.png", UriKind.Relative);
                    лампочка_готовности.Source = bi3;
                }
                if ((string)(row.ItemArray[0]) == "Не готов")
                {
                    bi3.UriSource = new Uri("Resources/rl.png", UriKind.Relative);
                    лампочка_готовности.Source = bi3;
                }
            }

            DB.closeConnection();

            bi3.EndInit();
        }

        private void двигатели_Click(object sender, RoutedEventArgs e)
        {
            zero_zindex();
            Panel.SetZIndex(таблица_двигатели, 1);
            table1.Rows.Clear();

            DB.openConnection();
            MySqlCommand command;
            command = new MySqlCommand("select `для привода оси`, `текущая температура`, `время снятия температуры` from var4.двигатели;", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(table1);
            таблица_двигатели.DataContext = table1;
            DB.closeConnection();
        }

        private void активные_сообщения_Click(object sender, RoutedEventArgs e)
        {
            zero_zindex();
            Panel.SetZIndex(таблица_активные_сообщения, 1);
            table2.Rows.Clear();

            DB.openConnection();
            MySqlCommand command;
            command = new MySqlCommand("select вид, время, канал, номер, текст  from var4.`активные сообщения`;", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(table2);
            таблица_активные_сообщения.DataContext = table2;
            DB.closeConnection();
        }

        private void оси_главного_движения_Click(object sender, RoutedEventArgs e)
        {
            zero_zindex();
            Panel.SetZIndex(таблица_оси_главного_движения, 1);
            table3.Rows.Clear();

            DB.openConnection();
            MySqlCommand command;
            command = new MySqlCommand("select название, положение, описание from var4.оси where название like \"%'\";", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(table3);
            таблица_оси_главного_движения.DataContext = table3;
            DB.closeConnection();
        }

        private void оси_движения_фрезерной_головы_Click(object sender, RoutedEventArgs e)
        {
            zero_zindex();
            Panel.SetZIndex(таблица_оси_движения_фрезерной_головы, 1);
            table4.Rows.Clear();

            DB.openConnection();
            MySqlCommand command;
            command = new MySqlCommand("select название, положение, описание from var4.оси where название not like \"%'\";", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(table4);
            таблица_оси_движения_фрезерной_головы.DataContext = table4;
            DB.closeConnection();
        }

        private void отобразить_график_Click(object sender, RoutedEventArgs e)
        {
            zero_zindex();
            Panel.SetZIndex(итоговый_график, 1);

            DB.openConnection();
            MySqlCommand command;

            DataTable dt2 = new DataTable();
            command = new MySqlCommand("SELECT `время на токарные операции` FROM var4.`виды работ за неделю`;", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(dt2);
            var data_Y1 = new List<double>();
            foreach (DataRow row in dt2.Rows)
            {
                data_Y1.Add((double)row.ItemArray[0]);
            }

            DataTable dt3 = new DataTable();
            command = new MySqlCommand("SELECT `временная метка суток` FROM var4.`виды работ за неделю`;", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(dt3);
            var data_Date = new List<DateTime>();
            foreach (DataRow row in dt3.Rows)
            {
                data_Date.Add((DateTime)row.ItemArray[0]);
            }

            DataTable dt4 = new DataTable();
            command = new MySqlCommand("SELECT `время на фрезерные операции` FROM var4.`виды работ за неделю`;", DB.GetConnection());
            adapter.SelectCommand = command;
            adapter.Fill(dt4);
            var data_Y2 = new List<double>();
            foreach (DataRow row in dt4.Rows)
            {
                data_Y2.Add((double)row.ItemArray[0]);
            }



            DB.closeConnection();

            double[] data_Ys1 = new double[data_Y1.Count];
            data_Y1.CopyTo(data_Ys1);
            double[] data_Ys2 = new double[data_Y2.Count];
            data_Y2.CopyTo(data_Ys2);
            DateTime[] data_Dates = new DateTime[data_Date.Count];
            data_Date.CopyTo(data_Dates);

            double[] data_Xs = data_Dates.Select(x => x.ToOADate()).ToArray();      //преобразование datetime к double для построения plotscatter
            double[] values_Ys2 = new double[data_Ys2.Length];
            for (int i = 0; i < data_Ys2.Length; i++)
                values_Ys2[i] = data_Ys1[i] + data_Ys2[i];
            итоговый_график.Plot.AddBar(values_Ys2, data_Xs);
            итоговый_график.Plot.AddBar(data_Ys1, data_Xs);
            итоговый_график.Plot.SetAxisLimits(yMin: 0);
            итоговый_график.Plot.XAxis.DateTimeFormat(true);
            итоговый_график.Plot.Title("График времени работы станка за неделю:\n затраты времени на токарные и на фрезерные операции");
            итоговый_график.Plot.XLabel("Дата/время");
            итоговый_график.Plot.YLabel("Часы");
            итоговый_график.Refresh();
        }
    }
}

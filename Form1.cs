using System;
using System.Drawing;
using System.Windows.Forms;
using System.Text.RegularExpressions;

namespace NewAppendixLayout
{
	public partial class APPendix : Form
	{
		public APPendix()
		{
			InitializeComponent();
			textBox1.ReadOnly = true;
			textBox2.ReadOnly = true;
			textBox3.ReadOnly = true;
			textBox4.ReadOnly = true;
			//comboBox1
		}

		private void button2_Click(object sender, EventArgs e)
		{
			this.Close();
		}

		private void textBox1_Keypress(object sender, KeyPressEventArgs e)
		{
			if (!char.IsControl(e.KeyChar) && !char.IsNumber(e.KeyChar))
			{
				e.Handled = true;
			}
		}

		private void textBox2_Keypress(object sender, KeyPressEventArgs e)
		{
			if (!char.IsControl(e.KeyChar) && !char.IsNumber(e.KeyChar))
			{
				e.Handled = true;
			}
		}
		private void textBox3_Keypress(object sender, KeyPressEventArgs e)
		{
			if (!char.IsControl(e.KeyChar) && !char.IsLetterOrDigit(e.KeyChar))
			{
				e.Handled = true;
			}
		}
		private void textBox4_Keypress(object sender, KeyPressEventArgs e)
		{
			if (!char.IsControl(e.KeyChar) && !char.IsLetterOrDigit(e.KeyChar))
			{
				e.Handled = true;
			}
		}

		private void button1_Click(object sender, EventArgs e)
		{
			textBox1.ReadOnly = false;

			
			textBox2.ReadOnly = false;
			label25.Text = textBox2.Text.Length.ToString();
			{
				label25.Text = textBox2.Text.Length.ToString();
				if (textBox2.Text.Length >= 32)
				{
					label29.Text = "Max";
					label29.ForeColor = Color.FromArgb(255, 0, 0);
					label29.Font = new Font(label29.Font, FontStyle.Bold);
				}
				if (textBox2.Text.Length < 32)
				{
					label29.Text = "Close";
					label29.ForeColor = Color.FromArgb(255, 174, 3);
					label29.Font = new Font(label29.Font, FontStyle.Italic);
				}
				if (textBox2.Text.Length < 26)
				{
					label29.Text = "Good";
					label29.ForeColor = Color.FromArgb(3, 145, 3);
					label29.Font = new Font(label29.Font, FontStyle.Regular);
				}
			}

			textBox3.ReadOnly = false;
			{
				label37.Text = textBox3.Text.Length.ToString();
				if (textBox3.Text.Length >= 32)
				{
					label36.Text = "Max";
					label36.ForeColor = Color.FromArgb(255, 0, 0);
					label36.Font = new Font(label36.Font, FontStyle.Bold);
				}
				if (textBox3.Text.Length < 32)
				{
					label36.Text = "Close";
					label36.ForeColor = Color.FromArgb(255, 174, 3);
					label36.Font = new Font(label36.Font, FontStyle.Italic);
				}
				if (textBox3.Text.Length < 26)
				{
					label36.Text = "Good";
					label36.ForeColor = Color.FromArgb(3, 145, 3);
					label36.Font = new Font(label36.Font, FontStyle.Regular);
				}
			}

			textBox4.ReadOnly = false;

		}

		private void textBox2_TextChanged(object sender, EventArgs e)
		{
			label25.Text = textBox2.Text.Length.ToString();
			if (textBox2.Text.Length >= 32)
			{
				label29.Text = "Max";
				label29.ForeColor = Color.FromArgb(255, 0, 0);
				label29.Font = new Font(label29.Font, FontStyle.Bold);
			}
			if (textBox2.Text.Length < 32)
			{
				label29.Text = "Close";
				label29.ForeColor = Color.FromArgb(255, 174, 3);
				label29.Font = new Font(label29.Font, FontStyle.Italic);
			}
			if (textBox2.Text.Length < 26)
			{
				label29.Text = "Good";
				label29.ForeColor = Color.FromArgb(3, 145, 3);
				label29.Font = new Font(label29.Font, FontStyle.Regular);
			}

			Regex rx = new Regex(@"^[a-zA-Z0-9_.() -+]+$", //allow letter, numbers and underscores
			RegexOptions.Compiled | RegexOptions.IgnoreCase);

			// Define a test string.
			string text = textBox2.Text;

			// Find matches.
			MatchCollection matches = rx.Matches(text);

			// Report on match.
			if (rx.IsMatch(text))
			{
				textBox2.ForeColor = Color.FromArgb(0, 0, 0);
				textBox2.Font = new Font(textBox2.Font, FontStyle.Regular);
			}
			else
			{
				textBox2.ForeColor = Color.FromArgb(255, 0, 0);
				textBox2.Font = new Font(textBox2.Font, FontStyle.Bold);
			}
		}
			
		private void textBox3_TextChanged(object sender, EventArgs e)
		{
			label37.Text = textBox3.Text.Length.ToString();
			if (textBox3.Text.Length >= 32)
			{
				label36.Text = "Max";
				label36.ForeColor = Color.FromArgb(255, 0, 0);
				label36.Font = new Font(label36.Font, FontStyle.Bold);
			}
			if (textBox3.Text.Length < 32)
			{
				label36.Text = "Close";
				label36.ForeColor = Color.FromArgb(255, 174, 3);
				label36.Font = new Font(label36.Font, FontStyle.Italic);
			}
			if (textBox3.Text.Length < 26)
			{
				label36.Text = "Good";
				label36.ForeColor = Color.FromArgb(3, 145, 3);
				label36.Font = new Font(label36.Font, FontStyle.Regular);
			}
			
			Regex rx = new Regex(@"^[a-zA-Z0-9_.() -+]+$", //allow letter, numbers and underscores
			RegexOptions.Compiled | RegexOptions.IgnoreCase);

			// Define a test string.
			string text = textBox3.Text;

			// Find matches.
			MatchCollection matches = rx.Matches(text);

			// Report on match.
			if (rx.IsMatch(text))
			{
				textBox3.ForeColor = Color.FromArgb(0, 0, 0);
				textBox3.Font = new Font(textBox3.Font, FontStyle.Regular);
			}
			else
			{
				textBox3.ForeColor = Color.FromArgb(255, 0, 0);
				textBox3.Font = new Font(textBox3.Font, FontStyle.Bold);
			}
		}
	}
}

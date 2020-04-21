using System;
using System.Windows.Forms;

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
			if (textBox2.Text.Length >=32)
			{
				label29.Text = "Max";
			}
			if (textBox2.Text.Length < 32)
			{
				label29.Text = "Good";
			}

			textBox3.ReadOnly = false;
			label37.Text = textBox3.Text.Length.ToString();
			if (textBox3.Text.Length >=32)
			{
				label36.Text = "Max";
			}
			if (textBox3.Text.Length < 32)
			{
				label36.Text = "Good";
			}

			textBox4.ReadOnly = false;
			//label39.Text = textBox4.Text.Length.ToString();
			//if (textBox4.Text.Length >= 32)
			//{
			//	label38.Text = "Max";
			//}
			//if (textBox4.Text.Length < 32)
			//{
			//	label38.Text = "Good";
			//}
		}

		private void textBox2_TextChanged(object sender, EventArgs e)
		{
			label25.Text = textBox2.Text.Length.ToString();
			if (textBox2.Text.Length >=32)
			{
				label29.Text = "Max";
			}
			if (textBox2.Text.Length <32)
			{
				label29.Text = "Good";
			}
		}
		private void textBox3_TextChanged(object sender, EventArgs e)
		{
			label37.Text = textBox3.Text.Length.ToString();
			if (textBox3.Text.Length >= 32)
			{
				label36.Text = "Max";
			}
			if (textBox3.Text.Length < 32)
			{
				label36.Text = "Good";
			}
		}
	}
}

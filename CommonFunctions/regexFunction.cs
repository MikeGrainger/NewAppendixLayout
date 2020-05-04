using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace NewAppendixLayout.CommonFunctions
{
	public class RegexFunction
	{
		Regex rx = new Regex(@"^[a-zA-Z0-9_.() -+]+$", //allow letter, numbers and underscores
		RegexOptions.Compiled | RegexOptions.IgnoreCase);



	}
}

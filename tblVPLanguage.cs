namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblVPLanguage
    {
        [Key]
        [Column(Order = 0)]
        public int LanguageID { get; set; }

        [Key]
        [Column(Order = 1)]
        [StringLength(50)]
        public string ProgLanguage { get; set; }

        [Key]
        [Column(Order = 2)]
        public bool FrontEnd { get; set; }

        [Key]
        [Column(Order = 3)]
        public bool BackEnd { get; set; }
    }
}

namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblBDApp_Admin
    {
        [Key]
        [Column(Order = 0)]
        public int BDApp_Admin_ID { get; set; }

        [Key]
        [Column(Order = 1)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_Number { get; set; }

        [Key]
        [Column(Order = 2)]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int BDApp_Admin_PID { get; set; }

        [Key]
        [Column(Order = 3)]
        public bool Active_Admin { get; set; }
    }
}

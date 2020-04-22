namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblVPAssystFix
    {
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Fix_Id { get; set; }

        [Key]
        [StringLength(50)]
        public string Assyst_Fix { get; set; }
    }
}

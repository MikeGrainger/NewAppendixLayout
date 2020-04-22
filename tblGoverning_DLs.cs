namespace NewAppendixLayout
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblGoverning_DLs
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblGoverning_DLs()
        {
            tblApplications = new HashSet<tblApplication>();
        }

        [Key]
        public int GDL_ID { get; set; }

        [Required]
        [StringLength(255)]
        public string Governing_DL { get; set; }

        [Required]
        public string List_Managers { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblApplication> tblApplications { get; set; }
    }
}

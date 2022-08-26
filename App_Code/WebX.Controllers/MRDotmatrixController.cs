using System.Data;
using System.Data.SqlClient;
using WebX.Common;

/// <summary>
/// Summary description for MRDotmatrixController
/// </summary>
/// 
namespace WebX.Controllers
{
    public class MRDotmatrixController : Base
    {
        public MRDotmatrixController()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public DataTable GetDocketdetails(string MRSNo)
        {
            return ExecuteDataTable("USP_MRView_GetMrDetails",
                new SqlParameter[] { new SqlParameter("@MRSNo", MRSNo)});
        }
        public DataTable    GetDocketdetails_Freight0(string MRSNo)
        {
            return ExecuteDataTable("USP_MRView_GetMrDetails_Freight0",
                new SqlParameter[] { new SqlParameter("@MRSNo", MRSNo) });
        }
    }
}
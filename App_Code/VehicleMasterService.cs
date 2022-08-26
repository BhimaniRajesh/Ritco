using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.Text;
using WebX.Common;
using WebX.Controllers;
using WebX.Entity;

[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "VehicleMasterService" in code, svc and config file together.
public class VehicleMasterService : IVehicleMasterService
{
    public List<AutoCompleteResult> GetState(string prefix)
    {
        try
        {
            var objVehicleMasterController = new VehicleMasterController();
            return objVehicleMasterController.GetState(prefix, "0").Select(s => new AutoCompleteResult { Value = s.StateCode, Name = s.StateCode }).ToList();
        }
        catch (Exception ex)
        {
            ExceptionUtils.LogException(ex, "GetState");
            return null;
        }
    }
    public List<StateResult> IsStateExist(string StateCode)
    {
        var objVehicleMasterController = new VehicleMasterController();
        DataTable dt = objVehicleMasterController.IsStateExist(StateCode);
        return (from DataRow dr in dt.Rows
                select new StateResult()
                {
                    IsStateExist = dr["IsStateExist"].ToString(),
                    StateCode = dr["StateCode"].ToString(),
                }).ToList();
    }
}

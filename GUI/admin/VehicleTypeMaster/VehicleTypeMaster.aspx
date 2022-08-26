<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="VehicleTypeMaster.aspx.cs" Inherits="GUI_admin_VehicleTypeMaster_VehicleTypeMasterAdd"
     %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">    
    <script language="javascript" type="text/javascript" src="../../images/CommonJs.js"></script>
    <script language="javascript" type="text/javascript">

/*****************************************************************************************************************
    THIS FUCNTION IS USED TO TEST VALID VEHICLE TYPE NAME
*****************************************************************************************************************/
function checkVehicleTypeName(id)
{
    var hdnVehicleTypeName=document.getElementById("ctl00_MyCPH1_hdnVehicleTypeName");
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	
	var vehicleTypeName = document.getElementById(id);
    vehicleTypeName.value = vehicleTypeName.value.toUpperCase();
	
	if(hdnVehicleTypeName.value != vehicleTypeName.value)
	{	
    	hdnajaxstate.value="1";    
    
        if(vehicleTypeName.value == "") 
        {   
            hdnajaxstate.value="0";
            return false;
        }    
   
        var findobj=false;
        findobj=GetXMLHttpObject();
        if(findobj)
        {
          var strpg="../AjaxResponse.aspx?mode=check&code1=vehtype&code2=" + vehicleTypeName.value + "&sid=" + Math.random() + "&sid=" + Math.random();
          findobj.open("GET", strpg);
          
             findobj.onreadystatechange=function()
             {
                 if((findobj.readyState==4) && (findobj.status==200))
                    {
                         var res = findobj.responseText.split("|");
                         if(res[0] == "true")
                         {
                               alert(res[1]);
                               vehicleTypeName.value = "";
                               vehicleTypeName.focus();
                               hdnajaxstate.value="0";
                               return false;                           
                          }
                          else if(res[0] == "false")
                          {
                            hdnajaxstate.value = "0";
                          }
                    }
             }         
           findobj.send(null);
          }    
    }
   return true;
}

function CalculateCapacity()
{      
       var txtGrosVehicleWeight = document.getElementById("ctl00_MyCPH1_txtGrosVehicleWeight");
       var txtUnladenWeight = document.getElementById("ctl00_MyCPH1_txtUnladenWeight");
       var txtPayload = document.getElementById("ctl00_MyCPH1_txtPayload");
              
       txtGrosVehicleWeight.value = roundNumber(txtGrosVehicleWeight.value, 2);
       txtUnladenWeight.value = roundNumber(txtUnladenWeight.value, 2);

       if (parseFloat(txtGrosVehicleWeight.value) < parseFloat(txtUnladenWeight.value))
       { 
           alert("Gross Vehicle Weight must be greater than Unladen Weight");       
           txtUnladenWeight.value = "";
           txtUnladenWeight.focus();
      	   return false;           
       }
       else
       {
           txtPayload.value = roundNumber(parseFloat(txtGrosVehicleWeight.value) - parseFloat(txtUnladenWeight.value), 2);
           return true;
       }              
}

/****************************************************************************************************************/
    
function btnsubmitClick()
{       
        var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        
        if(hdnajaxstate.value == "1")
        {
            alert("Let the Internal Processes over. Wait 5-10 Seconds.");
            return false;
        }
        
        var txtVehicleManufacturerNm = document.getElementById("ctl00_MyCPH1_txtVehicleManufacturerNm");
        var txtVehicleNm = document.getElementById("ctl00_MyCPH1_txtVehicleNm");
        var txtModelNo = document.getElementById("ctl00_MyCPH1_txtModelNo");
        var txtTypeDescription = document.getElementById("ctl00_MyCPH1_txtTypeDescription");
        var txtGrosVehicleWeight = document.getElementById("ctl00_MyCPH1_txtGrosVehicleWeight");
        var txtUnladenWeight = document.getElementById("ctl00_MyCPH1_txtUnladenWeight");
        var txtPayload = document.getElementById("ctl00_MyCPH1_txtPayload");
        var txtRateKm = document.getElementById("ctl00_MyCPH1_txtRateKm");     
        var txtLength = document.getElementById("ctl00_MyCPH1_txtLength");
        var txtWidth = document.getElementById("ctl00_MyCPH1_txtWidth");
        var txtHeight = document.getElementById("ctl00_MyCPH1_txtHeight");
        var txtFuelType = document.getElementById("ctl00_MyCPH1_txtFuelType");        
        var txtStationKM = document.getElementById("ctl00_MyCPH1_txtStationKM"); 
      
        if(txtVehicleManufacturerNm.value == "")
        {
            alert("Please enter Manufacturer Name.");
      		txtVehicleManufacturerNm.focus();
      	    return false;
        }        
       
        if(txtVehicleNm.value == "")
        {
            alert("Please enter Vehicle Name.");
      		txtVehicleNm.focus();
      	    return false;
        }        
       
        if (txtModelNo.value == "")
    	{
     	    alert("Please enter Model Number.");
      		txtModelNo.focus();
      	    return false;
    	}
       
        var ddlTruckTrailer = document.getElementById("ctl00_MyCPH1_ddlTruckTrailer");
        if(ddlTruckTrailer.value == "0")
        {
            alert("Select Truck / Trailer.");
            ddlTruckTrailer.focus();
            return false;
        }
        
//        if(txtStationKM.value == "")
//        {
//            alert("Please enter Tyre rotation at Km.");
//      		txtStationKM.focus();
//      	    return false;
//        }
//        
//        if(txtTypeDescription.value == "")
//        {
//            alert("Please enter Type Description.");
//      		txtTypeDescription.focus();
//      	    return false;
//        }        
       
        if (txtGrosVehicleWeight.value == "")
    	{
     	    alert("Please enter Gross Vehicle Weight.")
      		txtGrosVehicleWeight.focus();
      	    return false;
    	}    	
    	
    	if (txtUnladenWeight.value == "")
    	{
     	    alert("Please enter Unladen Weight.")
      		txtUnladenWeight.focus();
      	    return false;
    	}    	
    	
//    	txtPayload.value = parseInt(txtGrosVehicleWeight.value) - parseInt(txtUnladenWeight.value)
//    	if (txtPayload.value == "")
//    	{
//     	    alert("Please enter Payload.")
//      		txtPayload.focus();
//      	    return false;
//    	}
    	
//    	if (txtRateKm.value == "")
//    	{
//     	    alert("Please enter perKM Rate.")
//      		txtRateKm.focus();
//      	    return false;
//    	}    	
    	
    	if(txtFuelType.value == "")
    	{
    	    alert("Please enter Fuel Type.");
      		txtFuelType.focus();
      	    return false;
    	}    	
    	
    	if (txtHeight.value == "")
    	{
     	    alert("Please enter Height.")
      		txtHeight.focus();
      	    return false;
    	} 
    	
    	if (txtLength.value == "")
    	{
     	    alert("Please enter Length.")
      		txtLength.focus();
      	    return false;
    	}
    	if (txtWidth.value == "")
    	{
     	    alert("Please enter Width.")
      		txtWidth.focus();
      	    return false;
    	}    	   
    	
    	if(!confirm("Are you sure you want to Submit this Record ?"))
            return false;
            	
    	return true;
}
    </script>  
    <asp:Panel ID="Panel1" runat="server" Width="10in">
    <br />
    <br />
    <asp:Table HorizontalAlign="left" CellSpacing="1" Width="100%" CssClass="stbl"
        runat="server" ID="tblMain">
        <asp:TableRow CssClass="hrow">
            <asp:TableCell HorizontalAlign="center" CssClass="blackfnt" ColumnSpan="6" Style="height: 20px;">
                   <b>Vehicle Type Master</b></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="nrow">
            <asp:TableCell  Style="width: 150px">
                    Vehicle Type Code </asp:TableCell>
            <asp:TableCell Style="width: 150px">
                  <asp:Label ID="lblVehicleCode" CssClass="redfnt" runat="server">&lt;System Generated&gt;</asp:Label>                
            </asp:TableCell>
            <asp:TableCell Style="width: 175px">
                    <font color="red">*</font> Vehicle Manufacturer Name 
            </asp:TableCell>
            <asp:TableCell ColumnSpan="3" Style="width: 150px">
                <asp:TextBox ID="txtVehicleManufacturerNm" CssClass="blackfnt" BorderStyle="Groove" onblur="javascript:this.value = this.value.toUpperCase()"
                    runat="server" Width="300px" MaxLength="48" onkeypress="javascript:return withoutQuote(event)"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>     
        <asp:TableRow CssClass="nrow">
            <asp:TableCell>
                    <font color="red">*</font> Vehicle Name. </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtVehicleNm" CssClass="blackfnt" BorderStyle="Groove" onblur="javascript:return checkVehicleTypeName(this.getAttribute('id'))"
                    runat="server" Width="150px" MaxLength="48" onkeypress="javascript:return withoutQuote(event)"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell >
                    <font color="red">*</font> Model No.</asp:TableCell>
            <asp:TableCell ColumnSpan="3">
                <asp:TextBox ID="txtModelNo" CssClass="blackfnt" BorderStyle="Groove" runat="server" onblur="javascript:this.value = this.value.toUpperCase()"
                    Width="150px" MaxLength="48" onkeypress="javascript:return withoutQuote(event)"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
           <asp:TableRow CssClass="nrow">
            <asp:TableCell>
                    <font color="red">*</font> Truck / Trailer </asp:TableCell>
            <asp:TableCell>
                <asp:DropDownList ID="ddlTruckTrailer" runat="server" CssClass="blackfnt" Width="150px"></asp:DropDownList>
            </asp:TableCell>
            <asp:TableCell >
                      Tyre Rotation at Km </asp:TableCell>
            <asp:TableCell ColumnSpan="3">
                <asp:TextBox ID="txtStationKM" CssClass="blackfnt" BorderStyle="Groove" runat="server" 
                    Width="94px" MaxLength="18" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="nrow">
            <asp:TableCell VerticalAlign="top">
                     Type Description 
            </asp:TableCell>
            <asp:TableCell VerticalAlign="top">
                <asp:TextBox ID="txtTypeDescription" CssClass="blackfnt" onblur="javascript:this.value = this.value.toUpperCase()" BorderStyle="Groove" runat="server"
                    Width="150px" MaxLength="98"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell HorizontalAlign="left" VerticalAlign="top">
                    Active Flag</asp:TableCell>
            <asp:TableCell HorizontalAlign="left" VerticalAlign="top" ColumnSpan="3">
                <asp:CheckBox ID="chkactiveflag" Checked="true" runat="server" CssClass="blackfnt" />
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="hrow">
            <asp:TableCell HorizontalAlign="left" ColumnSpan="6" Font-Bold="true">
                   Capacity Information in Ton</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="nrow">
            <asp:TableCell VerticalAlign="top">
                    <font color="red">*</font> Gross Vehicle Weight                    
            </asp:TableCell>
            <asp:TableCell VerticalAlign="top">
                <asp:TextBox ID="txtGrosVehicleWeight" CssClass="blackfnt" BorderStyle="Groove" runat="server" onblur="javascript:return CalculateCapacity()"
                    Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                    Width="94px" MaxLength="11"></asp:TextBox>
                (Ton)
            </asp:TableCell>
            <asp:TableCell>
                    <font color="red">*</font> Unladen Weight 
            </asp:TableCell>
            <asp:TableCell Style="width: 150px">
                <asp:TextBox ID="txtUnladenWeight" CssClass="blackfnt" BorderStyle="Groove" runat="server" onblur="javascript:return CalculateCapacity();"
                    Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                    Width="94px" MaxLength="11"></asp:TextBox>
                (Ton)</asp:TableCell>
            <asp:TableCell Style="width: 100px">
                   <font color="red">*</font> Capacity </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtPayload" CssClass="blackfnt" Enabled="false" BorderStyle="Groove" runat="server" 
                    Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                    Width="94px" MaxLength="11"></asp:TextBox>(Ton)</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="nrow">
            <asp:TableCell>
                    Rate per KM</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtRateKm" CssClass="blackfnt" BorderStyle="Groove" runat="server" onblur="javascript:this.value = roundNumber(this.value, 2)"
                    Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                    Width="94px" MaxLength="11"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell>
                    <font color="red">*</font> Fuel Type</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtFuelType" CssClass="blackfnt" BorderStyle="Groove" runat="server" onblur="javascript:this.value = this.value.toUpperCase()"
                    onkeypress="javascript:return withoutQuote(event)" Width="94px"
                    MaxLength="48"></asp:TextBox>
            </asp:TableCell>
             <asp:TableCell>
                   <font color="red">*</font> Height</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtHeight" CssClass="blackfnt" BorderStyle="Groove" runat="server"
                    Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" onblur="javascript:this.value = roundNumber(this.value, 0)"
                    Width="94px" MaxLength="11"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>       
        <asp:TableRow CssClass="nrow">
            <asp:TableCell>
                   <font color="red">*</font> Length</asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtLength" CssClass="blackfnt" BorderStyle="Groove" runat="server"
                    Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" onblur="javascript:this.value = roundNumber(this.value, 0)"
                    Width="94px" MaxLength="11"></asp:TextBox>
            </asp:TableCell>
            <asp:TableCell>
                   <font color="red">*</font> Width </asp:TableCell>
            <asp:TableCell Style="width: 150px" ColumnSpan="3">
                <asp:TextBox ID="txtWidth" CssClass="blackfnt" BorderStyle="Groove" runat="server"
                    Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" onblur="javascript:this.value = roundNumber(this.value, 0)"
                    Width="94px" MaxLength="11"></asp:TextBox>
            </asp:TableCell>           
        </asp:TableRow>
        <asp:TableRow CssClass="frow">
            <asp:TableCell HorizontalAlign="Center" ColumnSpan="6">
                <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return btnsubmitClick()"     
                    CssClass="fbtn" Text="Submit" OnClick="btnSubmit_Click" />                
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <asp:HiddenField ID="hdnajaxstate" runat="server" />  
    <asp:HiddenField ID="hdnVehicleTypeName" runat="server" />    
   </asp:Panel>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="TransitionMasterEdit_Dval.aspx.cs" Inherits="GUI_admin_TransitionMaster_TransitionMasterEdit" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript"> 
    
    function IsNumericWoDot(sText)
    {
       var ValidChars = "0123456789";
       var IsNumber=true;
       var Char;

       for (i = 0; i < sText.length && IsNumber == true; i++) 
       { 
          Char = sText.charAt(i); 
          
          if (ValidChars.indexOf(Char) == -1) 
          {
            IsNumber = false;
          }
       }
       
       return IsNumber;
    }

     function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
    
    function ValidateData()
    {
        
        if(document.getElementById("ctl00_MyCPH1_chk1"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk1").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc1").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc1").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay1").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay1").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist1").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist1").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate1").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate1").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg1").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg1").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay1").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay1").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist1").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist1").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate1").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate1").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg1").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg1").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay1").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay1").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist1").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist1").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate1").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate1").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirPkg1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg1").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg1").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay1").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay1").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist1").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist1").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate1").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate1").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate1").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg1"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg1").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg1").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg1").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg1").focus();
                        return false;
                    }
                }
             }
        }
        
        
        if(document.getElementById("ctl00_MyCPH1_chk2"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk2").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc2").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc2").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay2").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay2").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist2").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist2").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate2").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate2").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg2").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg2").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay2").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay2").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist2").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist2").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate2").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate2").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg2").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg2").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay2").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay2").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist2").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist2").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate2").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate2").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirPkg2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg2").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg2").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay2").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay2").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist2").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist2").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate2").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate2").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate2").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg2"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg2").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg2").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg2").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg2").focus();
                        return false;
                    }
                }
             }
        }
        
        
        if(document.getElementById("ctl00_MyCPH1_chk3"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk3").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc3").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc3").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay3").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay3").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist3").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist3").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate3").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate3").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg3").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg3").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay3").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay3").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist3").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist3").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate3").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate3").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg3").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg3").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay3").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay3").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist3").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist3").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate3").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate3").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate3").focus();
                        return false;
                    }
                }
                
               if(document.getElementById("ctl00_MyCPH1_txtAirPkg3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg3").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg3").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay3").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay3").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist3").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist3").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate3").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate3").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate3").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg3"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg3").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg3").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg3").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg3").focus();
                        return false;
                    }
                }
             }
        }
        
        
        if(document.getElementById("ctl00_MyCPH1_chk4"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk4").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc4").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc4").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay4").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay4").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist4").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist4").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate4").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate4").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg4").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg4").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay4").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay4").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist4").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist4").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate4").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate4").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg4").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg4").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay4").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay4").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist4").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist4").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate4").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate4").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirPkg4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg4").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg4").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay4").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay4").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist4").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist4").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate4").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate4").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate4").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg4"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg4").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg4").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg4").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg4").focus();
                        return false;
                    }
                }
             }
        }
        
        
        if(document.getElementById("ctl00_MyCPH1_chk5"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk5").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc5").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc5").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay5").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay5").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist5").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist5").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate5").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate5").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg5").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg5").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay5").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay5").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist5").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist5").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate5").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate5").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg5").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg5").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay5").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay5").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist5").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist5").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate5").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate5").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirPkg5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg5").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg5").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay5").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay5").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist5").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist5").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate5").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate5").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate5").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg5"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg5").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg5").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg5").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg5").focus();
                        return false;
                    }
                }
             }
        }
        
        
        if(document.getElementById("ctl00_MyCPH1_chk6"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk6").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc6").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc6").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay6").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay6").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist6").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist6").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate6").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate6").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg6").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg6").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay6").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay6").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist6").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist6").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate6").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate6").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg6").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg6").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay6").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay6").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist6").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist6").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate6").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate6").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirPkg6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg6").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg6").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay6").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay6").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist6").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist6").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate6").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate6").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate6").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg6"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg6").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg6").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg6").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg6").focus();
                        return false;
                    }
                }
             }
        }
        
        
        if(document.getElementById("ctl00_MyCPH1_chk7"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk7").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc7").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc7").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay7").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay7").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist7").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist7").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate7").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate7").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg7").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg7").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay7").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay7").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist7").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist7").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate7").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate7").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg7").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg7").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay7").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay7").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist7").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist7").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate7").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate7").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirPkg7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg7").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg7").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay7").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay7").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist7").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist7").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate7").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate7").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate7").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg7"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg7").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg7").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg7").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg7").focus();
                        return false;
                    }
                }
             }
        }
        
        
        if(document.getElementById("ctl00_MyCPH1_chk8"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk8").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc8").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc8").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay8").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay8").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist8").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist8").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate8").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate8").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg8").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg8").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay8").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay8").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist8").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist8").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate8").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate8").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg8").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg8").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay8").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay8").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist8").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist8").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate8").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate8").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirPkg8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg8").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg8").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay8").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay8").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist8").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist8").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate8").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate8").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate8").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg8"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg8").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg8").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg8").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg8").focus();
                        return false;
                    }
                }
             }
        }
        
        
        if(document.getElementById("ctl00_MyCPH1_chk9"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk9").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc9").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc9").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay9").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay9").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist9").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist9").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate9").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate9").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg9").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg9").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay9").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay9").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist9").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist9").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate9").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate9").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg9").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg9").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay9").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay9").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist9").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist9").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate9").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate9").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirPkg9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg9").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg9").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay9").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay9").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist9").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist9").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate9").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate9").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate9").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg9"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg9").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg9").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg9").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg9").focus();
                        return false;
                    }
                }
             }
        }
        
        
        if(document.getElementById("ctl00_MyCPH1_chk10"))
        {
            if(document.getElementById("ctl00_MyCPH1_chk10").checked == true)
            {
                if(document.getElementById("ctl00_MyCPH1_txtCityLoc10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtCityLoc10").value == "")
                    {
                        alert("Enter City");
                        document.getElementById("ctl00_MyCPH1_txtCityLoc10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtDestLoc10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDestLoc10").value == "")
                    {
                        alert("Enter Destination Location");
                        document.getElementById("ctl00_MyCPH1_txtDestLoc10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDay10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDay10").value == "")
                    {
                        alert("Enter Rail Day");
                        document.getElementById("ctl00_MyCPH1_txtRailDay10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDay10").value) == false)
                    {
                        alert("Enter Rail Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDay10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailDist10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailDist10").value == "")
                    {
                        alert("Enter Rail Dist");
                        document.getElementById("ctl00_MyCPH1_txtRailDist10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailDist10").value) == false)
                    {
                        alert("Enter Rail Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailDist10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailRate10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailRate10").value == "")
                    {
                        alert("Enter Rail Rate");
                        document.getElementById("ctl00_MyCPH1_txtRailRate10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailRate10").value) == false)
                    {
                        alert("Enter Rail Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailRate10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRailPkg10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRailPkg10").value == "")
                    {
                        alert("Enter Rail Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRailPkg10").value) == false)
                    {
                        alert("Enter Rail Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDay10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDay10").value == "")
                    {
                        alert("Enter Road Day");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDay10").value) == false)
                    {
                        alert("Enter Road Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDay10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadDist10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadDist10").value == "")
                    {
                        alert("Enter Road Dist");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadDist10").value) == false)
                    {
                        alert("Enter Road Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadDist10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadRate10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadRate10").value == "")
                    {
                        alert("Enter Road Rate");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadRate10").value) == false)
                    {
                        alert("Enter Road Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRoadRate10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtRoadPkg10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtRoadPkg10").value == "")
                    {
                        alert("Enter Road Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtRoadPkg10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtRoadPkg10").value) == false)
                    {
                        alert("Enter Road Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtRailPkg10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDay10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDay10").value == "")
                    {
                        alert("Enter Air Day");
                        document.getElementById("ctl00_MyCPH1_txtAirDay10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDay10").value) == false)
                    {
                        alert("Enter Air Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDay10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirDist10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirDist10").value == "")
                    {
                        alert("Enter Air Dist");
                        document.getElementById("ctl00_MyCPH1_txtAirDist10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirDist10").value) == false)
                    {
                        alert("Enter Air Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirDist10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirRate10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirRate10").value == "")
                    {
                        alert("Enter Air Rate");
                        document.getElementById("ctl00_MyCPH1_txtAirRate10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirRate10").value) == false)
                    {
                        alert("Enter Air Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirRate10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtAirPkg10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirPkg10").value == "")
                    {
                        alert("Enter Air Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtAirPkg10").value) == false)
                    {
                        alert("Enter Air Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtAirPkg10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDay10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDay10").value == "")
                    {
                        alert("Enter Express Day");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDay10").value) == false)
                    {
                        alert("Enter Express Day in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDay10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressDist10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressDist10").value == "")
                    {
                        alert("Enter Express Dist");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressDist10").value) == false)
                    {
                        alert("Enter Express Dist in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressDist10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressRate10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressRate10").value == "")
                    {
                        alert("Enter Express Rate");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressRate10").value) == false)
                    {
                        alert("Enter Express Rate in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressRate10").focus();
                        return false;
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtExpressPkg10"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtExpressPkg10").value == "")
                    {
                        alert("Enter Express Rate/Pkg");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg10").focus();
                        return false;
                    }
                    else if(IsNumericWoDot(document.getElementById("ctl00_MyCPH1_txtExpressPkg10").value) == false)
                    {
                        alert("Enter Express Rate/Pkg in Postive Numeric Format");
                        document.getElementById("ctl00_MyCPH1_txtExpressPkg10").focus();
                        return false;
                    }
                }
             }
        }
        
        return true;
    }
    
    
            
     function checknumeric(obj,objname)
      {
	    if (obj.value=="")
	     {
	       alert("Please enter '" + objname + "'")
	       obj.focus();
	       return false;
	     }

	    if (isNaN(obj.value))
	     {
	       alert("Please enter '" + objname + "' in numeric")
	       obj.focus();
	       return false;
	     }

	    if (parseFloat(obj.value)<0)
	     {
	       alert("'" + objname + "' should not be negative")
	       obj.focus();
	       return false;
	     }
     }
      
</script>

<asp:UpdatePanel ID="upTable" runat="server">
	<ContentTemplate> 

<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr> 
			<td>&nbsp;</td>
		</tr>

		<tr> 
			<td> 
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
					<tr> 
						<td height="30" align="left">
							<a href=""><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Operations</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Transition Master</b></font>
						</td>
					</tr>
				        
					<tr> 
						<td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
					</tr>
					
					<tr> 
						<td style="height: 13px"><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
					</tr>

					<tr> 
						<td align="right">
							<a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
						</td>
					</tr>
					
					<%--</table> 
                  </td> 
                </tr> --%>
                <tr>
                 <td>
                   <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="100%">
	                    <tr class="bgbluegrey" >
		                    <td align="center" colspan="19"><font class="blackfnt"><b>--Transition Master--<asp:Label ID="lblMsg" runat="server"
                                    Font-Bold="False" ForeColor="#FF8080" CssClass="blackfnt"></asp:Label></b></font></td>
	                    </tr>

	                    <tr class="bgbluegrey">
		                    <td align="left" rowspan="2">
			                    <font class="blackfnt"><b>Sr.<br />No.</b></font>
		                    </td>

		                    <td align="left" rowspan="2">
			                    <font class="blackfnt"><b>Origin<br />Branch</b></font>
		                    </td>

		                    <td align="left" rowspan="2">
			                    <font class="blackfnt"><b>Destination<br />Branch</b></font>
		                    </td>

		                    <td align="center" colspan="4">
			                    <font class="blackfnt"><b>Transition Mode - Rail</b></font>
		                    </td>

		                    <td align="center" colspan="4">
			                    <font class="blackfnt"><b>Transition Mode - Road</b></font>
		                    </td>	

		                    <td align="center" colspan="4">
			                    <font class="blackfnt"><b>Transition Mode - Air</b></font>
		                    </td>
		                    <td align="center" colspan="4">
			                    <font class="blackfnt"><b>Transition Mode - Express</b></font></td>
	                    </tr>


	                    <tr class="bgbluegrey">
		                    <!--Rail-->
		                    <td align="center">
			                    <font class="blackfnt">Days</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Dist.</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Rate/Kg.</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Rate/Pkg</font>
		                    </td>

		                    <!--Road-->
		                    <td align="center">
			                    <font class="blackfnt">Days</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Dist.</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Rate/Kg.</font>
		                    </td>

		                    <td align="center" style="width: 50px">
			                    <font class="blackfnt">Rate/Pkg</font>
		                    </td>
                    		
		                    <!--Air-->
		                    <td align="center">
			                    <font class="blackfnt">Days</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Dist.</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Rate/Kg.</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Rate/Pkg</font>
		                    </td>
		                    <!--Express-->
		                    <td align="center">
			                    <font class="blackfnt">Days</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Dist.</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Rate/Kg.</font>
		                    </td>

		                    <td align="center">
			                    <font class="blackfnt">Rate/Pkg</font>
		                    </td>
	                    </tr>
	                    
	                    <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px; height: 9px;">
                                                          <asp:CheckBox ID="chk1" runat="server" AutoPostBack="True" />
                                                          </td>
                                                        <td style="width: 128px; height: 9px;">
                                                            <asp:TextBox ID="txtCityLoc1" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px; height: 9px;">
                                                            <asp:TextBox ID="txtDestLoc1" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label70" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(11)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px; height: 9px;">
                                                            <asp:TextBox ID="txtRailDay1" runat="server" Width="35px"></asp:TextBox></td> <%--onblur="return checknumeric(this,'Value')"></asp:TextBox></td>--%>
                                                        <td style="height: 9px; width: 42px;">
                                                            <asp:TextBox ID="txtRailDist1" runat="server" Width="35px"></asp:TextBox>&nbsp; <%--onblur="return checknumeric(this,'Value')"></asp:TextBox>&nbsp;--%>
                                                        </td>
                                                        <td style="width: 41px; height: 9px;">
                                                            <asp:TextBox ID="txtRailRate1" runat="server" Width="35px"></asp:TextBox>&nbsp; <%--onblur="return checknumeric(this,'Value')"></asp:TextBox>&nbsp;--%>
                                                        </td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtRailPkg1" runat="server" Width="35px"></asp:TextBox> <%--onblur="return checknumeric(this,'Value')"></asp:TextBox>--%>
                                                            </td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtRoadDay1" runat="server" Width="35px"></asp:TextBox> <%--onblur="return checknumeric(this,'Value')"></asp:TextBox>--%>
                                                            </td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtRoadDist1" runat="server" Width="35px"></asp:TextBox> <%--onblur="return checknumeric(this,'Value')"></asp:TextBox>--%>
                                                            </td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtRoadRate1" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px; height: 9px" align="center">
                                                            &nbsp;<asp:TextBox ID="txtRoadPkg1" runat="server" Width="35px"></asp:TextBox></td><td style="height: 9px">
                                                                <asp:TextBox ID="txtAirDay1" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirDist1" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirRate1" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirPkg1" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDay1" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDist1" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressRate1" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressPkg1" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px; height: 15px;">
                                                            <asp:CheckBox ID="chk2" runat="server" /></td>
                                                        <td style="width: 128px; height: 15px;">
                                                            <asp:TextBox ID="txtCityLoc2" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label61" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(2)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px; height: 15px;">
                                                            <asp:TextBox ID="txtDestLoc2" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label71" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(12)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px; height: 15px;">
                                                            <asp:TextBox ID="txtRailDay2" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="width: 42px; height: 15px;">
                                                            <asp:TextBox ID="txtRailDist2" runat="server" Width="35px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td style="width: 41px; height: 15px;">
                                                            <asp:TextBox ID="txtRailRate2" runat="server" Width="35px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRailPkg2" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRoadDay2" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRoadDist2" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRoadRate2" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px; height: 15px;" align="center">
                                                            &nbsp;<asp:TextBox ID="txtRoadPkg2" runat="server" Width="35px"></asp:TextBox></td><td style="height: 15px">
                                                                <asp:TextBox ID="txtAirDay2" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtAirDist2" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirRate2" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirPkg2" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDay2" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDist2" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressRate2" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressPkg2" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk3" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc3" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label62" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(3)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtDestLoc3" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label72" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(13)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtRailDay3" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRailDist3" runat="server" Width="35px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRailRate3" runat="server" Width="35px"></asp:TextBox>
                                                            &nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRailPkg3" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDay3" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDist3" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadRate3" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px" align="center">
                                                            &nbsp;<asp:TextBox ID="txtRoadPkg3" runat="server" Width="35px"></asp:TextBox></td><td>
                                                                <asp:TextBox ID="txtAirDay3" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDist3" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirRate3" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirPkg3" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDay3" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDist3" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressRate3" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressPkg3" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk4" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc4" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label63" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(4)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtDestLoc4" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label73" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(14)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtRailDay4" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRailDist4" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRailRate4" runat="server" Width="35px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRailPkg4" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDay4" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDist4" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadRate4" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px" align="center">
                                                            &nbsp;<asp:TextBox ID="txtRoadPkg4" runat="server" Width="35px"></asp:TextBox></td><td>
                                                                <asp:TextBox ID="txtAirDay4" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDist4" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirRate4" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirPkg4" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDay4" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDist4" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressRate4" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressPkg4" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk5" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc5" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label64" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(5)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtDestLoc5" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label74" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(15)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtRailDay5" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRailDist5" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRailRate5" runat="server" Width="35px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRailPkg5" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDay5" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDist5" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadRate5" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px" align="center">
                                                            &nbsp;<asp:TextBox ID="txtRoadPkg5" runat="server" Width="35px"></asp:TextBox></td><td>
                                                                <asp:TextBox ID="txtAirDay5" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDist5" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirRate5" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirPkg5" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDay5" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDist5" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressRate5" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressPkg5" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk6" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc6" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label65" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(6)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtDestLoc6" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label75" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(16)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtRailDay6" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRailDist6" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRailRate6" runat="server" Width="35px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRailPkg6" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDay6" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDist6" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadRate6" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px" align="center">
                                                            &nbsp;<asp:TextBox ID="txtRoadPkg6" runat="server" Width="35px"></asp:TextBox></td><td>
                                                                <asp:TextBox ID="txtAirDay6" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDist6" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirRate6" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirPkg6" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDay6" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDist6" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressRate6" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressPkg6" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk7" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc7" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label66" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(7)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtDestLoc7" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label76" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(17)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtRailDay7" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRailDist7" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRailRate7" runat="server" Width="35px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRailPkg7" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDay7" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDist7" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadRate7" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px" align="center">
                                                            &nbsp;<asp:TextBox ID="txtRoadPkg7" runat="server" Width="35px"></asp:TextBox></td><td>
                                                                <asp:TextBox ID="txtAirDay7" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDist7" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirRate7" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirPkg7" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDay7" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDist7" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressRate7" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressPkg7" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk8" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc8" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label67" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(8)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtDestLoc8" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label77" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(18)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtRailDay8" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRailDist8" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRailRate8" runat="server" Width="35px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRailPkg8" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDay8" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDist8" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadRate8" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px" align="center">
                                                            &nbsp;<asp:TextBox ID="txtRoadPkg8" runat="server" Width="35px"></asp:TextBox></td><td>
                                                                <asp:TextBox ID="txtAirDay8" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDist8" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirRate8" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirPkg8" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDay8" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDist8" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressRate8" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressPkg8" runat="server" Width="35px"></asp:TextBox></td>    
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px">
                                                            <asp:CheckBox ID="chk9" runat="server" /></td>
                                                        <td style="width: 128px">
                                                            <asp:TextBox ID="txtCityLoc9" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label68" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(9)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px">
                                                            <asp:TextBox ID="txtDestLoc9" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label78" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(19)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px">
                                                            <asp:TextBox ID="txtRailDay9" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="width: 42px">
                                                            <asp:TextBox ID="txtRailDist9" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 41px">
                                                            <asp:TextBox ID="txtRailRate9" runat="server" Width="35px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRailPkg9" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDay9" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadDist9" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtRoadRate9" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px" align="center">
                                                            &nbsp;<asp:TextBox ID="txtRoadPkg9" runat="server" Width="35px"></asp:TextBox></td><td>
                                                                <asp:TextBox ID="txtAirDay9" runat="server" Width="35px"></asp:TextBox>
                                                            </td>
                                                        <td>
                                                            <asp:TextBox ID="txtAirDist9" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirRate9" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtAirPkg9" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDay9" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressDist9" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressRate9" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 9px">
                                                            <asp:TextBox ID="txtExpressPkg9" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 16px; height: 15px;">
                                                            <asp:CheckBox ID="chk10" runat="server" /></td>
                                                        <td style="width: 128px; height: 15px;">
                                                            <asp:TextBox ID="txtCityLoc10" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label69" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(10)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 124px; height: 15px;">
                                                            <asp:TextBox ID="txtDestLoc10" runat="server" Width="69px"></asp:TextBox>
                                                            <asp:Label ID="Label79" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(20)">...</a>'
                                                                Width="15px"></asp:Label></td>
                                                        <td style="width: 120px; height: 15px;">
                                                            <asp:TextBox ID="txtRailDay10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="width: 42px; height: 15px">
                                                            <asp:TextBox ID="txtRailDist10" runat="server" Width="31px" ></asp:TextBox>
                                                            </td>
                                                        <td style="width: 41px; height: 15px;">
                                                            <asp:TextBox ID="txtRailRate10" runat="server" Width="31px"></asp:TextBox>&nbsp;
                                                        </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRailPkg10" runat="server" Width="31px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRoadDay10" runat="server" Width="31px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRoadDist10" runat="server" Width="31px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtRoadRate10" runat="server" Width="31px"></asp:TextBox>
                                                            </td>
                                                        <td style="width: 50px; height: 15px;" align="left">
                                                            <asp:TextBox ID="txtRoadPkg10" runat="server" Width="35px"></asp:TextBox></td><td style="height: 15px">
                                                                <asp:TextBox ID="txtAirDay10" runat="server" Width="31px"></asp:TextBox>
                                                            </td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtAirDist10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtAirRate10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtAirPkg10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtExpressDay10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtExpressDist10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtExpressRate10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtExpressPkg10" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>	
	                 </table>
                    <%--</td> 
                   </tr>
				 </table> --%>
               </table> 
               </td> 
          </tr>
          <tr>
          <td align="center">
              <asp:Button ID="btnSubmit" runat="server" OnClientClick="return ValidateData()" OnClick="btnSubmit_Click" Text="Submit" /></td></tr>
           
       </table>
       
        </ContentTemplate>
	</asp:UpdatePanel>  

</asp:Content>


<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Agent_Bill_Entry.aspx.cs" Inherits="GUI_Octroi_Ver1_Octroi_Bill_Agent_Bill_Entry" %>

<%@ Register Src="../../Common_UserControls/OctroiBillEntry.ascx" TagName="OctroiBillEntry"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../JS/Octroi.js"></script>

    <script language="javascript" type="text/javascript">
    
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
    
        function validFloat(event,txtid)
        {
            var tb=document.getElementById(txtid);
            var txt=tb.value;
            if(event.keyCode==13)
            return true;

            if(event.keyCode==46)
            if(txt.indexOf('.')!=-1)
            event.keyCode=0;

            if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
            {event.keyCode=0;return false;}
        }
        
        function rounditn(Num,decplaces)
        {
            Places=decplaces
            if (Places > 0)
            {
                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1))
                {
                    if (Num.toString().lastIndexOf('.') < 0)
                    {
                        return Num.toString() +'.00';
                    }
                    var Rounder = Math.pow(10, Places);
                    return Math.round(Num * Rounder) / Rounder;
                }
                else
                {            
                    if (Num.toString().lastIndexOf('.') < 0)
                    {
                        return Num.toString() +'.00';
                    }
                    else
                    {
                        if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
                                return Num.toString() +'0';
                        else
                                return Num.toString();
                    }
                }
            }
            else 
                return Math.round(Num);
        }
        
        function validDate(id)
        {

            var txtdate=document.getElementById(id);    
            if(!isValidDate(txtdate.value,"Date"))
            txtdate.focus();
            return false;
        }
        
        function validGridDate(id)
        {

            var txtdate=document.getElementById(id);    
            if(!isValidDate(txtdate.value,"Date"))
            txtdate.focus();
            
            var grid=document.getElementById("ctl00_MyCPH1_OctroiBillEntry1_gvBillEntry");            
            var rows=grid.rows.length;	        
	        var FormName="ctl00$MyCPH1$OctroiBillEntry1$gvBillEntry$ctl";//02$txtoctamt"	        
	        var total_octamt=0;
            var octamount=0;            
    	            for (i=0;i<rows-2;i++ )
    	            {
        	            j=i+2;
	                    if(j<10)
        	            {
            		            GV_frmname=FormName+"0"+j+"$"	
	                    }
        	            else
        	            {
		                    GV_frmname=FormName+j+"$"        
        	            }
            	                	        
	                    octamount=document.getElementById(GV_frmname+"txtoctamt").value;	                    
	                    document.getElementById(GV_frmname+"hidoctamt").value = octamount;	                    
	                    
	                    var rcpno=document.getElementById(GV_frmname+"txtrcpno").value;
	                    document.getElementById(GV_frmname+"hidrcpno").value = rcpno;	                    
	                    
	                    var rcpdt=document.getElementById(GV_frmname+"txtrcpdt").value;
	                    document.getElementById(GV_frmname+"hidrcpdt").value = rcpdt;
	                }
            return false;
        }
        
        function Add_Value()
        {             
	        var txtoctamt = document.getElementById("ctl00_MyCPH1_octamt");
	        var txtagnttax =document.getElementById("ctl00_MyCPH1_txtagnttax");
	        var txtothrchg = document.getElementById("ctl00_MyCPH1_txtothrchg");
	        var txtfrmcharg = document.getElementById("ctl00_MyCPH1_txtfrmcharg");
	        var txtclearchrg = document.getElementById("ctl00_MyCPH1_txtclearchrg");	        
	        var txttotdue = document.getElementById("ctl00_MyCPH1_txttotdue");
	        var txtserchgper = document.getElementById("ctl00_MyCPH1_txtserchgper");
	        var txtservicetxtchrg = document.getElementById("ctl00_MyCPH1_txtservicetxtchrg");
	        var txtsundry = document.getElementById("ctl00_MyCPH1_txtsundry");
	        var hidTotDue = document.getElementById("ctl00_MyCPH1_hidTotDue");
	        var hidOctAmt = document.getElementById("ctl00_MyCPH1_hidOctAmt");
	        var hidserchgper = document.getElementById("ctl00_MyCPH1_hidserchgper");
	        	        
	        if((txtagnttax.value)<0)
	        {
	            alert("Please Enter Positive Value");
	            txtagnttax.focus();
	            return false;
	        }
	        
	        var grid=document.getElementById("ctl00_MyCPH1_OctroiBillEntry1_gvBillEntry");            
            var rows=grid.rows.length;	        
	        var FormName="ctl00$MyCPH1$OctroiBillEntry1$gvBillEntry$ctl";//02$txtoctamt"
	        
	        var total_octamt=0;
            var octamount=0;            
    	            for (i=0;i<rows-2;i++ )
    	            {
        	            j=i+2;
	                    if(j<10)
        	            {
            		            GV_frmname=FormName+"0"+j+"$"	
	                    }
        	            else
        	            {
		                    GV_frmname=FormName+j+"$"        
        	            }
            	                	        
	                    octamount=document.getElementById(GV_frmname+"txtoctamt").value;	                    
	                    document.getElementById(GV_frmname+"hidoctamt").value = octamount;	                    
	                    
	                    var rcpno=document.getElementById(GV_frmname+"txtrcpno").value;
	                    document.getElementById(GV_frmname+"hidrcpno").value = rcpno;	                    
	                    
	                    var rcpdt=document.getElementById(GV_frmname+"txtrcpdt").value;
	                    document.getElementById(GV_frmname+"hidrcpdt").value = rcpdt;	                                   
	                    	                    
        	            if(octamount=="")
        	            {
        	                octamount=0;
        	            }
	                    if (document.getElementById(GV_frmname+"txtdockno").value!="")
	                    {  
     		                 total_octamt=parseFloat(total_octamt)+parseFloat(octamount);
     	                }       
	                }
	            
	                k=j+1;
	                if(k<10)
        	        {
                        GV_frmname1=FormName+"0"+k+"$"        
		            }
        	        else
        	        {
	                  GV_frmname1=FormName+k+"$"
        	        }
	                document.getElementById(GV_frmname1+"txttot").value=total_octamt;   
	                document.getElementById(GV_frmname1+"hidtot").value=total_octamt;
	                
	                txtoctamt.value=total_octamt;	                
	                hidTotDue.value=total_octamt;   
            
	               var TotDue = parseFloat(txtagnttax.value) + parseFloat(txtothrchg.value) + parseFloat(txtfrmcharg.value) + parseFloat(txtclearchrg.value) + parseFloat(txtsundry.value);
	               var percentage = 0;
	               
	               if(parseFloat(txtoctamt.value)!=0)
	               {
	                    var percentage = parseFloat(txtagnttax.value) * 100 /parseFloat(txtoctamt.value);
                   }
                   
	               txtserchgper.value = rounditn(parseFloat(percentage),3);

	               txttotdue.value = parseFloat(TotDue)+parseFloat(document.getElementById(GV_frmname1+"txttot").value);
	               hidTotDue.value = txttotdue.value;
	               hidOctAmt.value = txtoctamt.value;
	               hidserchgper.value = txtserchgper.value;
            }            
            
            function getDockData(txtid)
            {                
                var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	                hdnajaxstate.value="1";

                var len = txtid.length;
                var pref = txtid.substring(0,len-9);
                
                var txt=document.getElementById(txtid);
                if(txt.value=="") 
                {   
                    hdnajaxstate.value="0";
                    return false;
                }
               
                txt.value=txt.value.toUpperCase();
                var strpg="";
                var findobj=false;
                findobj=GetXMLHttpObject();
                if(findobj)
                {
                 strpg="AjaxResponse.aspx?mode=data&code1=octdet&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

                 findobj.open("GET",strpg);
                 findobj.onreadystatechange=function()
                     {
                         if((findobj.readyState==4) && (findobj.status==200))
                            {                            
                                  var res=findobj.responseText.split("|");
                                  if(res[0]=="false")
                                     {     
                                        var hidDockDate=document.getElementById(pref +"hidDockDate");                                    
                                        var hidStatus=document.getElementById(pref +"hidStatus");
                                        hidDockDate.value=res[1];
                                        hidStatus.value=res[2];
                                        hdnajaxstate.value="0";
                                        return false;
                                     }
                                  else if(res[0]=="true")
                                  {
                                        hdnajaxstate.value="0";
                                        var txtoctamt=document.getElementById(pref +"txtoctamt");
                                        var txtrcpno=document.getElementById(pref +"txtrcpno");
                                        var txtrcpdt=document.getElementById(pref +"txtrcpdt"); 
                                        
                                        var hidoctamt=document.getElementById(pref +"hidoctamt"); 
                                        var hidrcpno=document.getElementById(pref +"hidrcpno"); 
                                        var hidrcpdt=document.getElementById(pref +"hidrcpdt");                                        
                                        var hidDockDate=document.getElementById(pref +"hidDockDate");
                                        var hidStatus=document.getElementById(pref +"hidStatus");  
                                                                              
                                        txtoctamt.value=res[1];
                                        txtoctamt.disabled = true;
                                        hidoctamt.value = txtoctamt.value;
                                        
                                        txtrcpno.value=res[2];
                                        txtrcpno.disabled = true;
                                        hidrcpno.value = txtrcpno.value;
                                        
                                        txtrcpdt.value=res[3];
                                        txtrcpdt.disabled = true;
                                        hidrcpdt.value = txtrcpdt.value;
                                        
                                        hidDockDate.value=res[4];
                                        hidStatus.value=res[5]; 
                                        checkDocketNo(txt);                                                                               
                                        Add_Value();
                                  }
                                  else if(res[0]=="InValid")
                                  {
                                    alert("InValid Docket No...");
                                    var txtdockno=document.getElementById(pref +"txtdockno");
                                    txtdockno.value = "";
                                    txtdockno.focus();                           
                                  }
                                  else if(res[0]=="InValidDocket")
                                  {
                                    alert(res[1]);
                                    var txtdockno=document.getElementById(pref +"txtdockno");
                                    txtdockno.value = "";
                                    txtdockno.focus();                           
                                  }
                            }
                     }
                    
                findobj.send(null);
                }
               return true;
            }
            
            function checkDocketNo(obj)
            {            
                var grid=document.getElementById("ctl00_MyCPH1_OctroiBillEntry1_gvBillEntry");            
                var rows=grid.rows.length;	        
	            var FormName="ctl00$MyCPH1$OctroiBillEntry1$gvBillEntry$ctl";
	            var count=0;       
	               
    	            for (i=0;i<rows-2;i++ )
    	            {
        	            j=i+2;
	                    if(j<10)
        	            {
            		            GV_frmname=FormName+"0"+j+"$"	
	                    }
        	            else
        	            {
		                    GV_frmname=FormName+j+"$"        
        	            }
            	                	        
	                    var txtdockno=document.getElementById(GV_frmname+"txtdockno");
	                    var txtoctamt=document.getElementById(GV_frmname +"txtoctamt");
                        var txtrcpno=document.getElementById(GV_frmname +"txtrcpno");
                        var txtrcpdt=document.getElementById(GV_frmname +"txtrcpdt"); 	                                           
                        
                        if(obj.value == txtdockno.value)
                        {
                            count=count+1;                            
                            if(count>1)
                            {
                                alert("Docket No already entered.");
                                obj.value = "";
                                txtoctamt.value = "";
                                txtrcpno.value = "";
                                txtrcpdt.value = "";
                                obj.focus();
                                return false;
                            }
                        }
                    }                
            }            
    </script>

    <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
	 
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
    </script>

    <div>
        <br />
        <table width="900" align="left">
            <tr>
                <td>
                    <asp:Panel ID="pnlerror" Visible="false" runat="server">
                        <table width="90%">
                            <tr>
                                <td>
                                    <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Label ID="Label4" Text="Please Try Again....." runat="server"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <asp:Panel ID="pnlHeader" runat="server">
                        <br />
                        <br />
                        <table border="0" cellpadding="2" cellspacing="1" class="boxbg" width="800" align="left">
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                   Agent Bill Summary
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td style="width: 205px">
                                    <font class="blackfnt">Bill Entry Number</font>
                                </td>
                                <td style="width: 195px">
                                    <font class="blackfnt" color="red">System Generated...</font>
                                </td>
                                <td style="width: 200px">
                                    <font class="blackfnt"><font class="blackfnt">Bill date</font> </font>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtbilldt" Width="65px" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                                                    MaxLength="10"></asp:TextBox>
                                            </td>
                                            <td>
                                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtbilldt,'anchor3','dd/MM/yyyy'); return false;"
                                                    name="anchor3" id="a1">
                                                    <img src="./../../images/calendar.jpg" border="0"></img>
                                                </a>
                                            </td>
                                            <td>
                                                <font class="blackfnt">dd/mm/yyyy</font>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td>
                                    <font class="blackfnt">Octroi Agent </font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOctAgent" runat="server" Width="170px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                    <%--<atlas:AutoCompleteExtender runat="server" ID="Extender1">
                                        <atlas:AutoCompleteProperties Enabled="True" TargetControlID="txtOctAgent" ServiceMethod="GetOctroiVendor"
                                            ServicePath="../AtlasAutoComplete.asmx" MinimumPrefixLength="1" />
                                    </atlas:AutoCompleteExtender>--%>
                                    <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                                        ServiceMethod="GetOctroiVendor" CompletionListItemCssClass="autocomplete_listItem"
                                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                                        TargetControlID="txtOctAgent">
                                    </ajaxToolkit:AutoCompleteExtender>
                                </td>
                                <td>
                                    <font class="blackfnt">Agent Bill number</font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtagntbillno" runat="server" Width="91px" BorderStyle="Groove"
                                        CssClass="blackfnt"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatordd" runat="server" ErrorMessage="*"
                                        ControlToValidate="txtagntbillno"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td style="height: 25px">
                                    <font class="blackfnt">Octroi paid by Agent Rs.</font>
                                </td>
                                <td style="height: 25px">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="octamt" runat="server" Width="91px" onblur="javascript:return Add_Value()"
                                            Enabled="False" Text="0" BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right"></asp:TextBox>
                                        <asp:HiddenField ID="hidOctAmt" runat="server" />
                                    </font>
                                </td>
                                <td style="height: 25px">
                                    <font class="blackfnt">Agent Bill date</font>
                                </td>
                                <td style="height: 25px">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtagntbilldt" runat="server" Width="65px" BorderStyle="Groove"
                                                    CssClass="blackfnt" MaxLength="10"></asp:TextBox>
                                            </td>
                                            <td>
                                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtagntbilldt,'anchor4','dd/MM/yyyy'); return false;"
                                                    name="anchor4" id="a2">
                                                    <img src="./../../images/calendar.jpg" border="0"></img>
                                                </a>
                                            </td>
                                            <td>
                                                <font class="blackfnt">dd/mm/yyyy</font>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td>
                                    <font class="blackfnt">Agent service charge</font>
                                </td>
                                <td>
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtagnttax" runat="server" Width="91px" onblur="javascript:return Add_Value()"
                                            BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right">0</asp:TextBox></font>
                                </td>
                                <td>
                                    <font class="blackfnt">Service Charge(%)</font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtserchgper" runat="server" Width="91px" Text="0" onblur="javascript:return Add_Value()"
                                        Enabled="False" BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right"></asp:TextBox>
                                    <asp:HiddenField ID="hidserchgper" runat="server" />
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td>
                                    <font class="blackfnt">Other Charges</font>
                                </td>
                                <td>
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtothrchg" runat="server" Width="91px" onblur="javascript:return Add_Value()"
                                            BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right">0</asp:TextBox></font>
                                </td>
                                <td>
                                    <font class="blackfnt">Service Tax charged</font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtservicetxtchrg" runat="server" Enabled="false" Text="0" Width="91px"
                                        onblur="javascript:return Add_Value()" BorderStyle="Groove" CssClass="blackfnt"
                                        Style="text-align: right"></asp:TextBox>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td>
                                    <font class="blackfnt">Form charges</font>
                                </td>
                                <td>
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtfrmcharg" runat="server" Width="91px" onblur="javascript:return Add_Value()"
                                            BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right">0</asp:TextBox></font>
                                </td>
                                <td>
                                    <font class="blackfnt">Sundry charges</font>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtsundry" runat="server" Width="91px" onblur="javascript:return Add_Value()"
                                        BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right">0</asp:TextBox>
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td>
                                    <font class="blackfnt">Clearance charges</font>
                                </td>
                                <td>
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtclearchrg" runat="server" Width="91px" onblur="javascript:return Add_Value()"
                                            BorderStyle="Groove" CssClass="blackfnt" Style="text-align: right">0</asp:TextBox></font>
                                </td>
                                <td>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr bgcolor="white" style="height: 25px">
                                <td style="height: 25px">
                                    <font class="blackfnt">Total Due<asp:HiddenField ID="hidTotDue" runat="server" />
                                    </font>
                                </td>
                                <td style="height: 25px">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txttotdue" Enabled="false" runat="server" Width="91px" BorderStyle="Groove"
                                            CssClass="blackfnt" Style="text-align: right">0</asp:TextBox></font>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorttrr" runat="server" ErrorMessage="*"
                                        ControlToValidate="txttotdue"></asp:RequiredFieldValidator>
                                </td>
                                <td style="height: 25px">
                                    <font class="blackfnt">Due date</font>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtduedate" Width="65px" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                                                    MaxLength="10"></asp:TextBox>
                                            </td>
                                            <td>
                                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtduedate,'anchor5','dd/MM/yyyy'); return false;"
                                                    name="anchor5" id="a3">
                                                    <img src="./../../images/calendar.jpg" border="0"></img>
                                                </a>
                                            </td>
                                            <td>
                                                <font class="blackfnt">dd/mm/yyyy</font>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <uc1:OctroiBillEntry ID="OctroiBillEntry1" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <table align="left" cellspacing="1" cellpadding="3" width="800" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center">
                                <asp:HiddenField ID="click_count" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="Hnd_Server_dt" runat="server"></asp:HiddenField>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                                    BorderStyle="Groove" CssClass="blackfnt" OnClientClick="javascript:return OctroiBillEntry_OnSubmit()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0"></asp:HiddenField>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>

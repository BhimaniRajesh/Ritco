<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Vehicle_doc_step1.aspx.cs" Inherits="GUI_WebAdmin_Vehicle_Doc_master_Vehicle_doc_step1"   %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
var dtCh= "/";
var minYear=1900;
var maxYear=2100;
function  Check_num(obj,arg){
		if (isNaN(obj.value))
    	{
     	 alert("Please enter in numeric")
      		obj.focus();
      	return false;
    	}
	}

var months = new Array("","January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December");

function Chk(DDveytype,DDVehicle,ddVeh_doctype,btnSubmit)
        {

            if(DDveytype.value=="0")
		    {
		    alert("Select Atleast One Vehicle Type")
			        DDveytype.focus()
		        
		        return false;
		    }
		    
		    if(DDVehicle.value=="")
		    {
		    alert("Select Atleast One Vehicle ")
			        DDVehicle.focus()
		        
		        return false;
		    }
		    
		    if(ddVeh_doctype.value=="")
		    {
		    alert("Select Atleast One Vehicle Document Type")
			        ddVeh_doctype.focus()
		        
		        return false;
		    }
		 }
		 
		 
		 function ValidateForm(obj)
		 {

            if (obj.value!="")
            {
                if (isDate(obj.value)==false)
                  {
                    obj.focus()
                    return false
                   }
                return true
            }
        }
var dtCh= "/";
var minYear=1900;
var maxYear=2100;
function DaysArray(n) {
for (var i = 1; i <= n; i++) {
this[i] = 31
if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
if (i==2) {this[i] = 29}
}
return this
}
function isDate(dtStr){
var daysInMonth = DaysArray(12)

//alert(dtStr);
var pos1=dtStr.indexOf(dtCh)
var pos2=dtStr.indexOf(dtCh,pos1+1)
var strDay=dtStr.substring(0,pos1)
//alert("strDay : " + strDay);

var strMonth=dtStr.substring(pos1+1,pos2)
//alert("strMonth : " + strMonth);
var strYear=dtStr.substring(pos2+1)
strYr=strYear
//alert("strYr : " + strYr);

if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
//alert("1");
if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
//alert("2");
for (var i = 1; i <= 3; i++) {
if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
}
//alert("3");
month=parseInt(strMonth)
day=parseInt(strDay)
year=parseInt(strYr)
/*alert("strMonth : " + strMonth);
alert("strDay : " + strDay);
alert("strYr : " + strYr);
alert("month : " + month);
alert("day : " + day);
alert("year : " + year);*/


//alert("pos1 : " + pos1);
//alert("pos2 : " + pos2);
if (pos1==-1 || pos2==-1){
alert("The date format should be : dd/mm/yyyy")
return false
}
if (strMonth.length<1 || month<1 || month>12){
alert("Please enter a valid month")
return false
}
//alert("1111");
if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
alert("Please enter a valid day")
return false
}
//alert("2222");
if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
return false
}
//alert("33333")
if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
alert("Please enter a valid date")
return false
}
//alert("44444");
return true
//alert("55555");
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function Submitdata(DDveytype,DDVehicle,ddVeh_doctype,btnSubmit)
{


 if(DDveytype.value=="0")
		    {
		    alert("Select Atleast One Vehicle Type")
			        DDveytype.focus()
		        
		        return false;
		    }
		    
		    if(DDVehicle.value=="")
		    {
		    alert("Select Atleast One Vehicle ")
			        DDVehicle.focus()
		        
		        return false;
		    }
		    
		    if(ddVeh_doctype.value=="")
		    {
		    alert("Select Atleast One Vehicle Document Type")
			        ddVeh_doctype.focus()
		        
		        return false;
		    }

   Form_name="ctl00$MyCPH1$"  
 //  alert("hi")
   if (document.getElementById(Form_name+"ddVeh_doctype").value=="VD01")		
	{   // alert("hi1")
	
	
	    if(document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtPOLICY_NO").value=="")
				  {
				 // alert("hi2")
				   alert("Please Enter Policy No.")
				   document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtPOLICY_NO").focus();
				   return false;
				  }
				  
		if(document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value=="")
				  {
				         // alert("hi2")
				           alert("Please Start Date")
				           document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").focus();
				           return false;
				   }
				     if(document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value!="")
				      {
				          var  pdt=document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value
        				  
                       
                        dockdt_dd=pdt.substring(0,2)
                        dockdt_mm=parseInt(pdt.substring(3,5))
                        dockdt_yy=pdt.substring(6,10)
                        	var dockdt_user=new Date(months[parseFloat(dockdt_mm)] + " " + parseFloat(dockdt_dd) + ", " + parseFloat(dockdt_yy))
                        var dock_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                    
                            var dt ="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                            //var dt =document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value
                            var dt_dd=dt.substring(0,2)
                            var dt_mm=dt.substring(3,5)
                            // alert("hi")
                            var dt_yy=dt.substring(6,10)

                            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                            //alert(dt)
                           // alert(dockdt_user)
                            if (dt<dockdt_user)
                            {
                                alert( "Start date should not be Gretter than today's date !!!")
                                document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value.focus();
                                return false;
                            }
                    }



				  
			if(document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtEND_DATE").value=="")
				  {
				 // alert("hi2")
				   alert("Please End Date")
				   document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtEND_DATE").focus();
				   return false;
				  }  
				  
		if(document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtEND_DATE").value!="")
				  {
		             var  pdt1=document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtEND_DATE").value
        				  
                     //  alert("hi")
                        dockdt_dd=pdt1.substring(0,2)
                        dockdt_mm=parseInt(pdt1.substring(3,5))
                        dockdt_yy=pdt1.substring(6,10)
                        	var dockdt_user=new Date(months[parseFloat(dockdt_mm)] + " " + parseFloat(dockdt_dd) + ", " + parseFloat(dockdt_yy))
                        var dock_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                    
                            var dt ="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                            //var dt =document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value
                            var dt_dd=dt.substring(0,2)
                            var dt_mm=dt.substring(3,5)
                            // alert("hi")
                            var dt_yy=dt.substring(6,10)

                            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                          //  alert(dt)
                          // alert(dockdt_user)
                            if (dt>dockdt_user)
                            {
                                alert( "END date should not be less than today's date !!!")
                                document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtEND_DATE").value.focus();
                                return false;
                            }
				  }
				
				
				  
	}	
	
	
	if (document.getElementById(Form_name+"ddVeh_doctype").value=="VD02")		
	{   // alert("hi1")
	
	
	    if(document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtREG_NO").value=="")
				  {
				 // alert("hi2")
				   alert("Please Enter Reg. No.")
				   document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtREG_NO").focus();
				   return false;
				  }
				  
		if(document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtREG_DATE").value=="")
				  {
				         // alert("hi2")
				           alert("Please Reg. Date")
				           document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtREG_DATE").focus();
				           return false;
				   }
				     if(document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtREG_DATE").value!="")
				      {
				          var  pdt=document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtREG_DATE").value
        				  
                       
                        dockdt_dd=pdt.substring(0,2)
                        dockdt_mm=parseInt(pdt.substring(3,5))
                        dockdt_yy=pdt.substring(6,10)
                        	var dockdt_user=new Date(months[parseFloat(dockdt_mm)] + " " + parseFloat(dockdt_dd) + ", " + parseFloat(dockdt_yy))
                        var dock_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                    
                            var dt ="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                            //var dt =document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value
                            var dt_dd=dt.substring(0,2)
                            var dt_mm=dt.substring(3,5)
                            // alert("hi")
                            var dt_yy=dt.substring(6,10)

                            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                            //alert(dt)
                           // alert(dockdt_user)
                            if (dt<dockdt_user)
                            {
                                alert( "Reg. date should not be Gretter than today's date !!!")
                                document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtREG_DATE").value.focus();
                                return false;
                            }
                         
                    }



				  
			if(document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtFITNESS_VALIDITY_DATE").value=="")
				  {
				 // alert("hi2")
				   alert("Please Fitness Validity Date")
				   document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtFITNESS_VALIDITY_DATE").focus();
				   return false;
				  }  
				  
		if(document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtFITNESS_VALIDITY_DATE").value!="")
				  {
		             var  pdt1=document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtFITNESS_VALIDITY_DATE").value
        				  
                      // alert("hi")
                        dockdt_dd=pdt1.substring(0,2)
                        dockdt_mm=parseInt(pdt1.substring(3,5))
                        dockdt_yy=pdt1.substring(6,10)
                        	var dockdt_user=new Date(months[parseFloat(dockdt_mm)] + " " + parseFloat(dockdt_dd) + ", " + parseFloat(dockdt_yy))
                        var dock_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                    
                            var dt ="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                            //var dt =document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value
                            var dt_dd=dt.substring(0,2)
                            var dt_mm=dt.substring(3,5)
                            // alert("hi")
                            var dt_yy=dt.substring(6,10)

                            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                           // alert(dt)
                          // alert(dockdt_user)
                            if (dt>dockdt_user)
                            {
                                alert( "Fitness Validity date should not be less than today's date !!!")
                                document.getElementById("ctl00$MyCPH1$GV_D2$ctl02$txtFITNESS_VALIDITY_DATE").value.focus();
                                return false;
                            }
				  }
				
				
				  
	}	
	
	
	if (document.getElementById(Form_name+"ddVeh_doctype").value=="VD03")		
	{   // alert("hi1")
	
	
	 Form_name="ctl00$MyCPH1$"  
    maxrows=parseInt(document.getElementById(Form_name+"roww").value)
	
	//alert(maxrows)
	
	
	 if (maxrows>=1)
     {
		for(i=0;i<maxrows;i++)
			 {
			     j = i + 2;
	           
	            if(i < 10)
                {
                frm3=Form_name+"GV_D3$ctl"+"0"+j+"$"
                }
                else
                {
                  frm3=Form_name+"GV_D3$ctl"+j+"$"
                }
                   
             
			   if (document.getElementById(frm3+"ddState").value!="")		
			   {
				     if(document.getElementById(frm3+"txtPERMIT_NO").value=="")
				      {
				       alert("Please Permit No.")
				       document.getElementById(frm3+"txtPERMIT_NO").focus();
				       return false;
				      }
				      if(document.getElementById(frm3+"txtPERMIT_DATE").value=="")
				      {
				       alert("Please Permit Date")
				       document.getElementById(frm3+"txtPERMIT_DATE").focus();
				       return false;
				      }
				      if(document.getElementById(frm3+"txtEXPIRY_DATE").value=="")
				      {
				       alert("Please Expiry Date")
				       document.getElementById(frm3+"txtEXPIRY_DATE").focus();
				       return false;
				       
				       	      }
				       	      
				       	    if(document.getElementById(frm3+"txtEXPIRY_DATE").value!="")
				  {
		             var  pdt1=document.getElementById(frm3+"txtEXPIRY_DATE").value
        				  
                       //alert("hi")
                        dockdt_dd=pdt1.substring(0,2)
                        dockdt_mm=parseInt(pdt1.substring(3,5))
                        dockdt_yy=pdt1.substring(6,10)
                        	var dockdt_user=new Date(months[parseFloat(dockdt_mm)] + " " + parseFloat(dockdt_dd) + ", " + parseFloat(dockdt_yy))
                        var dock_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                    
                            var dt ="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                            //var dt =document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value
                            var dt_dd=dt.substring(0,2)
                            var dt_mm=dt.substring(3,5)
                            // alert("hi")
                            var dt_yy=dt.substring(6,10)

                            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                          //  alert(dt)
                          // alert(dockdt_user)
                            if (dt>dockdt_user)
                            {
                                alert( "Fitness Validity date should not be less than today's date !!!")
                                document.getElementById(frm3+"txtEXPIRY_DATE").focus();
                                return false;
                            }
				  }
				
			     }
			     else
			     {
			     alert("Please Select One state")
				       document.getElementById(frm3+"ddState").focus();
				       return false;
			     
			     }
			     
			}
	
	
	}
	
	
	
	}
				   	   
}	    </script>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr> 
		<td>&nbsp;</td>
	  </tr>
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
						<tr> 
						  
            <td height="30"><font class="blackfnt"><strong>
              Vehicle Document Master</strong></font>
              </td>
						</tr>
						<tr> 
						  <td class="horzblue"></td>
						</tr>
						<tr> 
							  <td>  </td>
							</tr>

        					<tr> 
         					 <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../../images/back.gif" border="0" alt="" /></a></td>
							 </tr>
        
      						 <tr> 
							  <td>  </td>
							</tr>
            </table></td>
        </tr>
      </table>

 <table border="0" class="boxbg" align="center"   cellspacing="1" cellpadding="1" width="70%">
                                                        <tr class="bgbluegrey" >
                                                        <td align="center" colspan="6"><font class="blackfnt"><b>Vehicle Document</b></font></td>
                                                        </tr>

                                                        <tr bgcolor="#ffffff">
                                                        
                                                        
                                                        <td align="left">
                                                        <font class="blackfnt">Vehicle  Type</font>
                                                        </td>


                                                        <td align="left">
                                                               <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                            <ContentTemplate>
                                                                 <asp:DropDownList  ID="DDveytype" runat="server" OnSelectedIndexChanged="vType_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                            </ContentTemplate>
                                                            
                                                        </asp:UpdatePanel>   
                                                        </td>
                                                        <td align="left">
                                                        <font class="blackfnt">Vehicle Code :</font>
                                                        </td>

                                                        <td align="left"><asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                            <ContentTemplate>
                                                                <%-- <asp:DropDownList  ID="DDVehicle" runat="server" ></asp:DropDownList>--%>
                                                                 <asp:DropDownList  ID="DDVehicle" AutoPostBack="false" runat="server"  ></asp:DropDownList>
                                                                <%-- <asp:ListItem  Text="--Select--" Value="" ></asp:ListItem>--%>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="DDveytype" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                            
                                                        </asp:UpdatePanel>  </td>

                                                        
                                                        <tr bgcolor="#ffffff">
                                                        
                                                         <td align="left" >
                                                        <font class="blackfnt" >Vehicle Document Type</font>
                                                        </td>


                                                        <td align="left" colspan="3">
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                            <ContentTemplate>
                                                                 <asp:DropDownList  ID="ddVeh_doctype" AutoPostBack="true" runat="server" OnSelectedIndexChanged="DOC_TYPE_SelectedIndexChanged" ></asp:DropDownList>
                                                            </ContentTemplate>
                                                            
                                                        </asp:UpdatePanel>           
                                                        </td></tr>
                                                        </tr>
                                                        <tr bgcolor="#ffffff">
                                                        <td colspan="4">
                                                        <asp:UpdatePanel ID="DataGrid2_Update" runat="server" UpdateMode="Always" RenderMode="Inline">
                 <ContentTemplate>
    
                    <center>
                         <table border="0" cellpadding="1" cellspacing="1" class="boxbg"  align="center">
           
            <tr id="ROW_ID" bgcolor="white"   runat="server" >
               <td align="left" style="width: 91px; height: 20px;" ><font class="blackfnt">
                   Enter Row No *</font></td><td style="height: 20px" >
                   <asp:TextBox ID="roww" runat="server" Width="40px" BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25" ></asp:TextBox></td>
             </tr>
         </table>
         <br /> 
                        </center>
                     <center>
                        </center>
                     <center>
                         <%--<asp:GridView id="DataGrid1" runat="server" AllowPaging="false" PageSize="1000" AutoGenerateColumns="False" CellPadding="1" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="90%">
                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
			            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" />--%>
                        
                         
                         <asp:GridView ID="GV_D3" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white" OnRowCommand="dg_RowCommand"
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1" >
                                                             
                                                                 <Columns>
                                                                 
                                                                 <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 <asp:HiddenField ID="SRNO" runat="server" />
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                                 
                                                                                                                                            
                                                                                    
                                                                                    
                                                                                     
                                                                                    
                                                                                     <asp:TemplateField HeaderText="STATE">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                <asp:DropDownList  ID="ddState" runat="server" ></asp:DropDownList>
                                                   
                                                                                     </ItemTemplate>
                                    
                                                                           
                                    
                                                                                    </asp:TemplateField>
                                                                                      
                                                                                        <asp:TemplateField HeaderText="PERMIT NO.">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtPERMIT_NO" Width="60" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="PERMIT DATE">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtPERMIT_DATE" Width="60" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                    <asp:TemplateField HeaderText="EXPIRY DATE">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtEXPIRY_DATE" Width="60" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                  <%--  <asp:TemplateField>
            <ItemTemplate>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                        Text="X" OnClientClick="return confirm('Are you certain that you want to delete this record?');">
                                    </asp:LinkButton>
                                 </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Wrap="False" />
            </asp:TemplateField>--%>
                                                                                   
                                                                                    
                                                                                   
                                                                                    
                                                                                    
                                                                                    </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle CssClass="bgbluegrey" />
                                                                                            </asp:GridView>  
 <asp:GridView ID="GV_D1" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white"
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1" >
                                                             
                                                                 <Columns>
                                                                 
                                                                 
                                                            
                                                                 <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                   <asp:HiddenField ID="SRNO" runat="server" />
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                                 
                                                                                                                                       
                                                                                    
                                                                                    
                                                                                     
                                                                                  <%--  
                                                                                     <asp:TemplateField HeaderText="State">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                <asp:DropDownList  ID="ddState" runat="server" ></asp:DropDownList>
                                                   
                                                                                     </ItemTemplate>
                                    
                                                                           
                                    
                                                                                    </asp:TemplateField>--%>
                                                                                      
                                                                                        <asp:TemplateField HeaderText="POLICY NO.">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtPOLICY_NO" Width="60" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="START DATE">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtSTART_DATE" Width="60" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                    <asp:TemplateField HeaderText="END DATE">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtEND_DATE" Width="60" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                
                                                                                    
                                                                                    
                                                                                    </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle CssClass="bgbluegrey" />
                                                                                            </asp:GridView>


<asp:GridView ID="GV_D2" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white"
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1" OnSelectedIndexChanged="GV_D2_SelectedIndexChanged" >
                                                             
                                                                 <Columns>
                                                                 
                                                                <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                   <asp:HiddenField ID="SRNO" runat="server" />
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                                 
                                                                                                                                            
                                                                                    
                                                                                    
                                                                                     
                                                                                    
                                                                                   <%--  <asp:TemplateField HeaderText="State">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                <asp:DropDownList  ID="ddState" runat="server" ></asp:DropDownList>
                                                   
                                                                                     </ItemTemplate>
                                    
                                                                           
                                    
                                                                                    </asp:TemplateField>--%>
                                                                                      
                                                                                        <asp:TemplateField HeaderText="REG. NO">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtREG_NO" Width="60" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="REG. DATE">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtREG_DATE" Width="60" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     
                                                                                     
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                    <asp:TemplateField HeaderText="FITNESS VALIDITY DATE">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtFITNESS_VALIDITY_DATE" Width="60" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                   
                                                                                    
                                                                                    
                                                                                    </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle CssClass="bgbluegrey" />
                                                                                            </asp:GridView>

				        
				     
				     </center>
                     <center>
                                                </center>
              </ContentTemplate>   
              <Triggers>
                <asp:AsyncPostBackTrigger ControlID="roww" EventName="TextChanged" />
              </Triggers>
        
               
            </asp:UpdatePanel>
                                                        </td>
                                                        </tr>
                                                        <tr  bgcolor="#ffffff">
											<td colspan="4" style="width: 659px"></td>
										</tr>
                                                        <tr  align="center" bgcolor="#ffffff"> 
											<td colspan="4" style="width: 659px">&nbsp;<asp:Button ID="btnSubmit" runat="server" Text="Submit"  OnClick="btnSubmit_Click" /></td>
										</tr>
										
										
                                                        </table>

</asp:Content>


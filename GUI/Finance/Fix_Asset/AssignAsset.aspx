<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="AssignAsset.aspx.cs" Inherits="GUI_UNI_MIS_TDS_STMT_TDS_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
    
    function nwOpen2(m1)
        {
        //debugger
            window.open("popupasset.aspx?cd=" + m1+"&nm="+m2,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
     function checklocation(obj)
        {
        
        var a;
        a=1;
     obj.value = obj.value.toUpperCase()
        //str=str.toUpperCase()
        
        if(obj.value != "")
        {
       for(i=0;i<str.length;i++)
       {
       
       str[i]=str[i].toUpperCase()

            if(obj.value==str[i])
            {
                 a=2
                  break;
               
                
            }
            else
            { 
               
                continue
            }
       }
      
       if(a!=2)
       {
             alert("Employee ID Does Not Exist....")
           obj.focus();
       }
       }
 

}  
 function checklocation2(obj)
        {
        
        var a;
        a=1;
     obj.value = obj.value.toUpperCase()
        //str=str.toUpperCase()
        
        if(obj.value != "")
        {
       for(i=0;i<str2.length;i++)
       {
       
       str2[i]=str2[i].toUpperCase()

            if(obj.value==str2[i])
            {
                 a=2
                  break;
               
                
            }
            else
            { 
               
                continue
            }
       }
      
       if(a!=2)
       {
             alert("Locaion Code Does Not Exist....")
           obj.focus();
       }
       }
 

}    
function ch()
{
 debugger
  
  var grid=document.getElementById("ctl00_MyCPH1_dgTDSRpt");
  var rows=grid.rows.length;      // "ctl00$MyCPH1$dgTDSRpt"
  var arrstr="";
  var q ="n";
  rows=rows-1;
  for(var b=2;b<=rows;b++)
  {
        var c="";
        var loc="";
        var desc="";
        var dep="";
        var emp="";
        var dt="";
        
        if(b<10)
        {
            c="ctl00_MyCPH1_dgTDSRpt_ctl0" + b + "_chksrno";
            loc="ctl00_MyCPH1_dgTDSRpt_ctl0" + b + "_txtloc";
            desc="ctl00_MyCPH1_dgTDSRpt_ctl0" + b + "_txtdesc";
            dep="ctl00_MyCPH1_dgTDSRpt_ctl0" + b + "_txtdeptnm";
            emp="ctl00_MyCPH1_dgTDSRpt_ctl0" + b + "_txtemp";
            dt="ctl00_MyCPH1_dgTDSRpt_ctl0" + b + "_txtdt";
            
        }
        else
        {
        
        
        
        c="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_chksrno";
            loc="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_txtloc";
            desc="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_txtdesc";
            dep="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_txtdeptnm";
            emp="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_txtemp";
            dt="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_txtdt";
            
//            c="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_chksrno";
//            c2="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_actch";
//            t="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_txtch";
//            
//             t2="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_txtdoc";
//            d="ctl00_MyCPH1_dgTDSRpt_ctl" + b + "_ddBound1";
            
        }
        
 
        var tb1=document.getElementById(c);
        
        var loc1=document.getElementById(loc);
        var emp1=document.getElementById(emp);
        
        var desc1=document.getElementById(desc);
        var dep1=document.getElementById(dep);
        var dt1=document.getElementById(dt);
        
        
 
  
      if(tb1.checked == true)
        {
            q="y"
           
            if(loc1.value=="")
            {
                alert("Location Name Can not ne Blanck....")
                loc1.focus();
                return false;
            }
            
            if(emp1.value=="")
            {
                alert("Employee Name Can not ne Blanck....")
                emp1.focus();
                return false;
            }
            if(dep1.value=="")
            {
                alert("Department Name Can not ne Blanck....")
                dep1.focus();
                return false;
            }
            if(desc1.value=="")
            {
                alert("Description Can not ne Blanck....")
                desc1.focus();
                return false;
            }
            if(dt1.value=="")
            {
                alert("Date Can not ne Blanck....")
                dt1.focus();
                return false;
            }
            if(!isValidDate(dt1.value,"Installation  Order"))
            {
                return false;
            }
            
            
           
 
            
              
            
            //return true;
        }
         
        

   } // END OF for

       if(q == "n")
        {
            alert("Please Select Atleast One....")
            return false;
        }
   
     return true;
 
}

	    
	     
     
	    function nwOpen2(m1)
        {
 //debugger
            window.open("poplloc.aspx?l=" + m1,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        function validInt(event)
{
if(event.keyCode==13)
{
return true;
}
if(event.keyCode<48 || event.keyCode>57)
{
event.keyCode=0;return false;
}
}

    </script>

    <div align="left" style="width: 10in">
        <br />
        <table align="left" style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <font class="blklnkund"><b>Finance</b></font></a> <b>&gt; </b><font class="blklnkund">
                            <b>Asset Management</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Assign Asset</b></font>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Panel ID="plnerr" Visible="false" runat="server">
            <table width="90%">
                <tr>
                    <td align="center">
                        <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label><br /><br /><br />
                         <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                         
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnl1" runat="server">
            <table cellspacing="1" style="width: 100%">
                <tr align="center">
                    <td align="Left">
                        <asp:UpdatePanel ID="u1" runat="server"  UpdateMode="Conditional">
                            <ContentTemplate>
                                <center>
                                    <asp:GridView ID="dgTDSRpt" runat="server" AllowPaging="True" BorderColor="#8BA0E5"
                                        BorderWidth="0" CellPadding="5" CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..."
                                        HeaderStyle-CssClass="dgHeaderStyle" OnPageIndexChanging="pgChange" PagerSettings-Mode="Numeric"
                                        OnRowDataBound="GV_D_OnRowDataBound" PagerStyle-HorizontalAlign="left" PageSize="25"
                                        AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SR.NO.">
                                                <HeaderStyle HorizontalAlign="Center" Font-Bold="true" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" CssClass="blackfnt" Width="50" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                                    </asp:Label>
                                                    <asp:CheckBox ID="chksrno" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="allotcd" ControlStyle-Width="5" HeaderText="AllotCD" HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Width="5" HorizontalAlign="Center" CssClass="blackfnt" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Assetcd" ItemStyle-Wrap="true" HeaderText="Asset Code"
                                                HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="fixedassetcd" ItemStyle-Wrap="true" HeaderText="GRN Code"
                                                HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="fixedassetdt" ItemStyle-Wrap="true" HeaderText="GRN Date"
                                                HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Billdt" ItemStyle-Wrap="true" HeaderText="Bill Date" HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Assetnm" ItemStyle-Wrap="true" HeaderText="Asset Name"
                                                HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="loccode" ControlStyle-Width="5" HeaderText="Current Location "
                                                HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Width="5" HorizontalAlign="Center" CssClass="blackfnt" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="allotcd" ControlStyle-Width="5" Visible="false" HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Width="5" HorizontalAlign="Center" CssClass="blackfnt" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Assigned to Location" HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtloc" Width="50" runat="server" onblur="return checklocation2(this)"
                                                        BorderStyle="Groove"></asp:TextBox><asp:Button ID="btncodepopup" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description" HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtdesc" Width="110" runat="server" TextMode="multiLine" BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Department Name " HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtdeptnm" Width="60" runat="server" BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Assigned to Employee" HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtemp" Width="60" onblur="return checklocation(this)" runat="server"
                                                        BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Installation Date (DD/MM/YYYY)" HeaderStyle-Font-Bold="true">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" CssClass="blackfnt" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtdt" Width="60" runat="server" orderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--   <asp:TemplateField HeaderText="Asset Code " HeaderStyle-Width="150">
                                        <HeaderStyle HorizontalAlign="Center" Width="100" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtassetcd" Width="60" runat="server" BorderStyle="Groove"></asp:TextBox><asp:Button ID="btncodepopup" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="GRN No. ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" Width="150" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtastnm" Width="170" MaxLength="4" runat="server" BorderStyle="Groove"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                        </Columns>
                                        <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                        <PagerStyle HorizontalAlign="Left" />
                                        <HeaderStyle CssClass="dgHeaderStyle" />
                                    </asp:GridView>
                                </center>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
                    <div style="width: 10in" align="center">
            <asp:Button ID="btn_csv" Text="Submit" runat="server" Width="170" OnClick="btn_submit_Click" /></div>
        </asp:Panel>
        <br />

    </div>
</asp:Content>

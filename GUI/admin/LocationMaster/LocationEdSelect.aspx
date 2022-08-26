<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="LocationEdSelect.aspx.cs" Inherits="LocationEdSelect" %>
<%@ OutputCache Location="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <script language="javascript" type="text/javascript">
        function trimAll(strValue) 
        {
            //Trimming left most white space characters
            while (strValue.substring(0,1) == ' ')
            {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length-1, strValue.length) == ' ')
            {
                strValue = strValue.substring(0, strValue.length-1);
            }
            
            return strValue;
        }
        function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        function checkloc()
        {
            //checkloc
            //debugger
            if (document.getElementById("ctl00$MyCPH1$txtacloc").value == "")
            {
                if((document.getElementById("ctl00$MyCPH1$ddhir").value == "--Select--") && (document.getElementById("ctl00$MyCPH1$ddloc").value == "--Select--"))
                {
                    alert("Please Select Atleast One Option Properly !!")
                    return false
                }
            }
        }
        function checklocation(obj)
       {
        //debugger
            obj.value = trimAll(obj.value);
            if (obj.value != "")
            {
                var a;
                a=1;
                obj.value = obj.value.toUpperCase()
                for(i=0;i<str.length;i++)
                {
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
                //debugger
                if (a!=2)
                {
                    alert("please enter valid location")
                    obj.value=""
                    obj.focus();
                    return false
                }
            }
       }
    </script>

    
        <div style="width:10in">
 <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
		<tr> 
			<td> 
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
					<tr>
                            <td align="left" style="height: 1px">
                                <a href=""><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a>
                                    <font class="blklnkund"><strong>Administrator </strong></font></a>&gt; <a href="../company_structure.aspx"><font
                                        class="blklnkund"><strong>Company Structure</strong></font></a> <font class="bluefnt">
                                            <strong>&gt;Location Listing</strong> </font>
                            </td>
                            <td align="right" style="height: 3px">
                                <a href="javascript:window.history.go(-1)" title="back">
                                    <img src="../../images/back.gif" border="0" alt="" /></a></td>
                        </tr>
			   </table>
	      </td>      
	   </tr> 
 </table>    
            <table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg" style="z-index: 100; left: 126px; position: absolute; top: 296px">
                <tr class="bgbluegrey"> 
                    <td  align="center" colspan="2"> 
                        <p align="center"><font class="blackfnt"><b>Select Location for Edit/Inactivation</b></font></p>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                    <td  align="center" valign="top" width="40%"> 
                        <div align="right"><font class="blackfnt">Select Hierarchy</font> 
                        : </div>
                    </td>
                    <td bgcolor="#FFFFFF"> 
                        <asp:UpdatePanel ID="upHir" runat="server">
   	                      <ContentTemplate>
                            <asp:DropDownList ID="ddHir" runat="server" OnSelectedIndexChanged="ddHir_SelectedIndexChanged"
                            Width="100px" AutoPostBack="True">
                            </asp:DropDownList>
                            
                          </ContentTemplate>
                        </asp:UpdatePanel>     
                     </td>        
                   </tr>

                <tr bgcolor="#FFFFFF"> 
                    <td  align="center" valign="top"> 
                        <div align="right"><font class="blackfnt">Select Location</font> 
                        : </div>
                    </td>
                    <td bgcolor="#FFFFFF"> 
           		            <div id="ReportingLocationCombo">
           		            <asp:UpdatePanel ID="upLoc" runat="server">
   	                          <ContentTemplate>
                                   <asp:DropDownList ID="ddLoc" runat="server">
                                   </asp:DropDownList>
                              </ContentTemplate>
                              <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="ddHir" EventName="SelectedIndexChanged" />
                              </Triggers> 
                            </asp:UpdatePanel>        
                           </div>
	                </td>
                 </tr>
   	           <tr bgcolor="#FFFFFF">
		            <td colspan="2" align="center"><font class="blackfnt"><b>OR</b></font> </td>
               </tr>
    
               <tr bgcolor="#FFFFFF">
		            <td align="right" style="height: 34px"><font class="blackfnt">Enter Location Code:</font> </td>
		            <td align="left" style="height: 34px">
                        <asp:TextBox ID="txtAcLoc" runat="server" onblur="checklocation(this)" Width="75px"></asp:TextBox>
                        <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen(1)">...</a>'
                            Width="14px"></asp:Label></td>
               </tr>
    
              
               <tr bgcolor="#FFFFFF" > 
                    <td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
                        <table style="width: 222px">
                            <tr>
                                <td>
                                <%--<asp:UpdatePanel ID="upBtns1" runat="server">
   	                                <ContentTemplate>--%>
                                        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
                                    <%--</ContentTemplate>
                                    <Triggers>
	                                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />    
	                                </Triggers> 
                                </asp:UpdatePanel> --%>
                                </td>
                                <td>
                                <%--<asp:UpdatePanel ID="upBtns2" runat="server">
   	                                <ContentTemplate> --%>   
                                        <asp:Button ID="btnEdit" OnClientClick="return checkloc()"  runat="server" Text="Edit" OnClick="btnEdit_Click" />
                                    <%--</ContentTemplate>
                                    <Triggers>
	                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />    
	                                </Triggers>
                                </asp:UpdatePanel> --%> 
                                </td>
                                <td>
                                <%--<asp:UpdatePanel ID="upBtns3" runat="server">
   	                                <ContentTemplate> --%>  
                                        <asp:Button ID="btnInactivate" runat="server" Text="Inactivate" OnClick="btnInactivate_Click" />
                                    <%--</ContentTemplate>
                                    <Triggers>
	                                    <asp:AsyncPostBackTrigger ControlID="btnInactivate" EventName="Click" />    
	                                </Triggers>
                                </asp:UpdatePanel>--%>
                                </td>
                                <td>
                                        <asp:Button ID="btnListing" runat="server" Text="Listing" PostBackUrl="~/GUI/admin/LocationMaster/ListAll.aspx"/>
                                </td>
                              </tr>
                        </table>
		                                   
                   </td>   
	               
	           </tr>
	          
	      </table>
	   </div> 
    </asp:Content>
    
    

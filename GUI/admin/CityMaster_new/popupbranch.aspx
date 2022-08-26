<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupbranch.aspx.cs" Inherits="popupbranch" %>


<link href="../../../GUI/Images/style.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>BranchList</title>
    
    <script language="javascript" type="text/javascript">
        
        function SelectLocation(objLocation)
        {
        //debugger
        hdnParam=document.getElementById("hdnParam");
        formObj = eval(objLocation);
        //alert(formObj.value);
            //var mNo = formObj.value
//            if(mNo == 1)
//            {
        window.opener.document.forms[0].document.getElementById(hdnParam.value).value = objLocation.value
//            }
//            else if(mNo == 2)
//            {
//                window.opener.document.forms[0].ctl00$MyCPH1$txtRoadBKG_loc.value = objLocation.value
//            }
//            else if(mNo == 3)
//            {
//                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc3.value = objLocation.value
//            }
//            else if(mNo == 4)
//            {
//                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc4.value = objLocation.value
//            }
//            else if(mNo == 5)
//            {
//                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc5.value = objLocation.value
//            }
//            else if(mNo == 6)
//            {
//                window.opener.document.forms[0].ctl00$MyCPH1$txtRdBkLoc6.value = objLocation.value
//            }
            
        }    
        
        
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="false" AllowSorting="true"
                            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..." 
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Width="350px" class="boxbg">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white" ItemStyle-Width="40px" >
                                    <ItemTemplate>
                                        <input name="MyRadioButton" type="radio" value='<%# Eval("loccode") %>' onclick="SelectLocation(this)"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="loccode" HeaderText="Location Code">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white" Width="80px" />
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="locname" HeaderText="Location Name">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white"/>
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                              </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                    
        &nbsp;
    <div>
    <asp:HiddenField ID="hdnParam" runat="server" />
        &nbsp;</div>
    </form>
</body>
</html>


                             

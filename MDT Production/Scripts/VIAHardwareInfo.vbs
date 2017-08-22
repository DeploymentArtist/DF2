' //***************************************************************************
' // ***** Script Header *****
' //
' // Solution:  Custom Script for use with the Microsoft Deployment Toolkit
' // File:      hardwareinfo.vbs
' //
' // Purpose:   User exit script to get and set properties to be able to display the HardwareInfo Wizardpane.
' //           
' // Usage:     Modify CustomSettings.ini similar to this:
' //        [Settings]
' //        Priority=Init, Default
' //        Properties=MyCustomProperty, SkipHardwareInfo, ComputerSystemNumberOfProcessors, ComputerSystemNumberOfLogicalProcessors, ComputerSystemProductIdentifyingNumber, SMBIOSVersion, CPUName, DiskDriveCaptation
' //
' //        [Init]
' //        ComputerSystemNumberOfProcessors=#SetComputerSystemNumberOfProcessors()#
' //        ComputerSystemNumberOfLogicalProcessors=#SetComputerSystemNumberOfLogicalProcessors()#
' //        ComputerSystemProductIdentifyingNumber=#SetComputerSystemProductIdentifyingNumber()#
' //        SMBIOSVersion=#SetBIOSSMBIOSVersion()#
' //        CPUName=#GetCPUName()#
' //        DiskDriveCaptation=#GetDiskDriveCaptation()#
' //
' // Version:   1.0
' // Author: Mikael Nystrom – http://deploymentbunny.com
' //***************************************************************************

Function UserExit(sType, sWhen, sDetail, bSkip)
    oLogging.CreateEntry "UserExit:HardwareInfo.vbs started: " & sType & " " & sWhen & " " & sDetail, LogTypeInfo
    UserExit = Success
End Function

Function SetComputerSystemNumberOfProcessors()
    oLogging.CreateEntry "UserExit:HardwareInfo.vbs – Getting ComputerSystemNumberOfProcessors", LogTypeInfo
    Dim objWMI
    Dim objResults
    Dim objInstance
    Dim NumberOfProcessors
    Dim ComputerSystemNumberOfProcessors

    Set objWMI = GetObject("winmgmts:")
    Set objResults = objWMI.InstancesOf("Win32_ComputerSystem")
        For each objInstance in objResults
            If Not IsNull(objInstance.NumberOfProcessors) Then
                NumberOfProcessors = Trim(objInstance.NumberOfProcessors)
            End If
        Next
            If NumberOfProcessors = "" Then
                NumberOfProcessors = "UNKNOWN"
            End If
    SetComputerSystemNumberOfProcessors = NumberOfProcessors
End Function

Function SetComputerSystemNumberOfLogicalProcessors()
    oLogging.CreateEntry "UserExit:HardwareInfo.vbs – Getting ComputerSystemNumberOfLogicalProcessors", LogTypeInfo
    Dim objWMI
    Dim objResults
    Dim objInstance
    Dim NumberOfLogicalProcessors
   
    Set objWMI = GetObject("winmgmts:")
    Set objResults = objWMI.InstancesOf("Win32_ComputerSystem")
        If Err then
        oLogging.CreateEntry "Error querying Win32_ComputerSystem: " & Err.Description & " (" & Err.Number & ")", LogTypeError
    Else
        For each objInstance in objResults
            If Not IsNull(objInstance.NumberOfLogicalProcessors) Then
                    NumberOfLogicalProcessors = Trim(objInstance.NumberOfLogicalProcessors)
            End If
        Next
    End If
    SetComputerSystemNumberOfLogicalProcessors = NumberOfLogicalProcessors
End Function

Function SetCPUName()
    oLogging.CreateEntry "UserExit:HardwareInfo.vbs – Getting CPUName", LogTypeInfo
    Dim objWMI
    Dim objResults
    Dim objInstance
    Dim Name
    Dim CPUName
   
    Set objWMI = GetObject("winmgmts:")
    Set objResults = objWMI.ExecQuery("SELECT * FROM Win32_Processor")
        If Err then
        oLogging.CreateEntry "Error querying FROM Win32_Processor: " & Err.Description & " (" & Err.Number & ")", LogTypeError
    Else
        For each objInstance in objResults
            If Not IsNull(objInstance.Name) Then
                    CPUName = Trim(objInstance.Name)
            End If
        Next
    End If
    SetCPUName = CPUName
End Function

Function SetBIOSSMBIOSVersion()
    oLogging.CreateEntry "UserExit:HardwareInfo.vbs – Getting BIOSSMBIOSVersion", LogTypeInfo
    Dim objWMI
    Dim objResults
    Dim objInstance
    Dim SMBIOSBIOSVersion
   
    Set objWMI = GetObject("winmgmts:")
    Set objResults = objWMI.ExecQuery("SELECT * FROM Win32_BIOS")
        If Err then
        oLogging.CreateEntry "Error querying Win32_ComputerSystem: " & Err.Description & " (" & Err.Number & ")", LogTypeError
    Else
        For each objInstance in objResults
            If Not IsNull(objInstance.SMBIOSBIOSVersion) Then
                    SMBIOSBIOSVersion = Trim(objInstance.SMBIOSBIOSVersion)
            End If
        Next
    End If
    SetBIOSSMBIOSVersion = SMBIOSBIOSVersion
End Function

Function SetDiskDriveCaptation()
    oLogging.CreateEntry "UserExit:HardwareInfo.vbs – Getting DiskDriveCaptation", LogTypeInfo
    Dim objWMI
    Dim objResults
    Dim objInstance
    Dim Caption
   
    Set objWMI = GetObject("winmgmts:")
           Set objResults = objWMI.ExecQuery("SELECT * FROM Win32_DiskDrive where mediatype like 'Fixed%hard disk%'")
        If Err then
        oLogging.CreateEntry "Error querying Win32_DiskDrive: " & Err.Description & " (" & Err.Number & ")", LogTypeError
    Else
        For each objInstance in objResults
            If Not IsNull(objInstance.Caption) Then
                    Caption = Trim(objInstance.Caption)
            End If
        Next
    End If
    SetDiskDriveCaptation = Caption
End Function

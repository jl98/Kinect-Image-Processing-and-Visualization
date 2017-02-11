﻿<Window x:Class="WPFKinectSDK18.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:k="http://schemas.microsoft.com/kinect/2013"
        xmlns:local="clr-namespace:WPFKinectSDK18"
        mc:Ignorable="d"
        Title="MainWindow" Height="350" Width="525">
    <Grid>
        <k:KinectSensorChooserUI HorizontalAlignment = "Center" VerticalAlignment="Top" Name="kinectChooser" >

        </k:KinectSensorChooserUI>

        <Label x:Name="KinectStatus" Content="Current Kinect Status" HorizontalAlignment="Center" VerticalAlignment="Center" FontSize="25" />

        <TextBlock x:Name="LeftWrist" HorizontalAlignment="Left" Margin="10,10,0,0" TextWrapping="Wrap" Text="Left Wrist" VerticalAlignment="Top"/>
        <TextBlock x:Name="XValueLeft" HorizontalAlignment="Left" Margin="25,30,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top"/>
        <TextBlock x:Name="XLeft" HorizontalAlignment="Left" Margin="10,30,0,0" TextWrapping="Wrap" Text="X:" VerticalAlignment="Top"/>
        <TextBlock x:Name="YValueLeft" HorizontalAlignment="Left" Margin="25,50,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top"/>
        <TextBlock x:Name="YLeft" HorizontalAlignment="Left" Margin="10,50,0,0" TextWrapping="Wrap" Text="Y:" VerticalAlignment="Top"/>
        <TextBlock x:Name="ZValueLeft" HorizontalAlignment="Left" Margin="25,70,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" RenderTransformOrigin="-2.933,3.159"/>
        <TextBlock x:Name="ZLeft" HorizontalAlignment="Left" Margin="10,70,0,0" TextWrapping="Wrap" Text="Z:" VerticalAlignment="Top" RenderTransformOrigin="0.165,0.661"/>

        <TextBlock x:Name="RightWrist" HorizontalAlignment="Left" Margin="431,13,0,0" TextWrapping="Wrap" Text="Right Wrist" VerticalAlignment="Top"/>
        <TextBlock x:Name="XValueRight" HorizontalAlignment="Left" Margin="447,33,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" RenderTransformOrigin="14.311,3.246"/>
        <TextBlock x:Name="XRight" HorizontalAlignment="Left" Margin="431,33,0,0" TextWrapping="Wrap" Text="X:" VerticalAlignment="Top"/>
        <TextBlock x:Name="YValueRight" HorizontalAlignment="Left" Margin="447,53,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" RenderTransformOrigin="6.452,3.458"/>
        <TextBlock x:Name="YRight" HorizontalAlignment="Left" Margin="431,53,0,0" TextWrapping="Wrap" Text="Y:" VerticalAlignment="Top"/>
        <TextBlock x:Name="ZValueRight" HorizontalAlignment="Left" Margin="447,73,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" RenderTransformOrigin="-2.933,3.159"/>
        <TextBlock x:Name="ZRight" HorizontalAlignment="Left" Margin="431,73,0,0" TextWrapping="Wrap" Text="Z:" VerticalAlignment="Top"/>

        <TextBlock x:Name="LeftGesture" HorizontalAlignment="Left" Margin="10,91,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Text="Left Hand:"/>
        <TextBlock x:Name="RightGesture" HorizontalAlignment="Left" Margin="431,91,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Text="Right Hand:"/>
        <TextBlock x:Name="LeftRaised" HorizontalAlignment="Left" Margin="10,112,0,0" TextWrapping="Wrap" VerticalAlignment="Top"/>
        <TextBlock x:Name="RightRaised" HorizontalAlignment="Left" Margin="431,112,0,0" TextWrapping="Wrap" VerticalAlignment="Top"/>

    </Grid>
</Window>

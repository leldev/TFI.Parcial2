<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TFI.Parcial2.Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Contenido del cuestionario</h1>
    <p>
        Un establecimiento educativo promueve cursos abiertos de diferentes disciplinas, cada curso tiene un costo específico, una fecha límite de inscripción, y un cupo máximo de alumnos que pueden inscribirse.
    </p>
    <p>
        Los alumnos pueden ser regulares (abonan el total del curso), alumnos con media beca y por último, alumnos con beca al 80%.
    </p>
    <p>
        Se requiere un sistema desarrollado en ASP.NET y C# que permita:
    </p>
    <ul>
        <li>Alta y modificación de cursos</li>
        <li>Alta de alumnos</li>
        <li>Alta de inscripciones con la beca correspondiente</li>
        <li>Informar mediante un evento cuando se quiera inscribir un alumno a un curso completo</li>
        <li>Informar mediante un evento cuando se quiera inscribir un alumno fuera de fecha</li>
        <li>Listar los cursos de forma ordenada por nombre</li>
        <li>Consultar la recaudación total y por curso </li>
    </ul>
    <p>
        Requisitos:
    </p>
    <ul>
        <li>Arquitectura 4 capas</li>
        <li>BD Sql Server</li>
        <li>Orientado a Objetos</li>
    </ul>
</asp:Content>

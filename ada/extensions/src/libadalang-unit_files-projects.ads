with Ada.Finalization;

with GNATCOLL.Projects; use GNATCOLL.Projects;

with Langkit_Support.Text; use Langkit_Support.Text;

with Libadalang.Analysis; use Libadalang.Analysis;

--  This package provides an Unit_File_Provider implemetation that relies on a
--  project file.

package Libadalang.Unit_Files.Projects is

   type Project_Unit_File_Provider_Type is limited
      new Unit_File_Provider_Interface
      with private;
   type Project_Unit_File_Provider_Access is
      access Project_Unit_File_Provider_Type;
   --  Unit_File_Provider implementation that relies on a project file

   function Create
     (Project          : Project_Tree_Access;
      Is_Project_Owner : Boolean)
      return Project_Unit_File_Provider_Type;
   --  Create an unit file provider using Project. If Is_Project_Owner is true,
   --  the result owns Project, thus the caller must not deallocate it itself.
   --  Otherwise, the project pointed by Project must outlive the returned unit
   --  file provider.

   overriding function Get_File
     (Provider : Project_Unit_File_Provider_Type;
      Node     : Ada_Node;
      Kind     : Unit_Kind)
      return String;

   overriding function Get_File
     (Provider : Project_Unit_File_Provider_Type;
      Name     : Text_Type;
      Kind     : Unit_Kind)
      return String;

   function Convert (Kind : Unit_Kind) return GNATCOLL.Projects.Unit_Parts is
     (case Kind is
      when Unit_Specification => GNATCOLL.Projects.Unit_Spec,
      when Unit_Body          => GNATCOLL.Projects.Unit_Body);

private

   type Project_Unit_File_Provider_Type is limited
      new Ada.Finalization.Limited_Controlled
      and Unit_File_Provider_Interface
   with record
      Project          : Project_Tree_Access;
      Is_Project_Owner : Boolean;
   end record;

   overriding procedure Initialize
     (Provider : in out Project_Unit_File_Provider_Type);
   overriding procedure Finalize
     (Provider : in out Project_Unit_File_Provider_Type);

   function Create
     (Project          : Project_Tree_Access;
      Is_Project_Owner : Boolean)
      return Project_Unit_File_Provider_Type
   is ((Ada.Finalization.Limited_Controlled with
        Project          => Project,
        Is_Project_Owner => Is_Project_Owner));

end Libadalang.Unit_Files.Projects;
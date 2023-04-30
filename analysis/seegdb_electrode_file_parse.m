function [output]=seegdb_electrode_file_parse(filename)


output=[];

[path,fstem,fext]=fileparts(filename);

%seegdb_dir=getenv('SEEGDB_DIR');
%if(~isempty(seegdb_dir))
    if(regexp(filename,regexptranslate('wildcard','elec*tal'))) %find all 'elec*.mat' files
        output=1; %MNI space
    elseif(regexp(filename,regexptranslate('wildcard','ta*elec*')))
        output=1; %MNI space
    else
        output=0; %native space
    end;
%end;
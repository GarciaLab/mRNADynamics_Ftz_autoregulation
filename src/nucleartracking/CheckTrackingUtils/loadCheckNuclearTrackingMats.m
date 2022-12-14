% loadCheckNuclearTrackingMats.m
% author: Gabriella Martini
% date created: 9/7/20
% date last modified: 9/7/20
% This function loads FrameInfo.mat and schnitz cells into
% the corresponding workspace variables.
function [FrameInfo, schnitzcells] = loadCheckNuclearTrackingMats(DataFolder, PreProcPath, FilePrefix)



schnitzcells = [];
schnitzPath = [DataFolder filesep, FilePrefix(1:end - 1), '_lin.mat'];
if  exist(schnitzPath, 'file')
    disp('Loading schnitzcells...')
    load(schnitzPath, 'schnitzcells');
    %Remove the schnitz fields that can give us problems potentially if
    %present. I don't know how this came to be, but it's for fields that
    %are not all that relevant. The fields are: approved, ang
    if isfield(schnitzcells, 'approved')
        schnitzcells = rmfield(schnitzcells, 'approved');
    end
    if isfield(schnitzcells, 'ang')
        schnitzcells = rmfield(schnitzcells, 'ang');
    end
    disp('schnitzcells loaded')
end





%Check that FrameInfo exists
if exist([DataFolder, filesep, 'FrameInfo.mat'], 'file')
    
    load([DataFolder, filesep, 'FrameInfo.mat'], 'FrameInfo')
    
else
    
    warning('No FrameInfo.mat found. Trying to continue')
    %Adding frame information
    DHis = dir([PreProcPath, filesep, FilePrefix(1:end - 1), filesep, '*His*.tif']);
    FrameInfo(length(DHis)).nc = [];
    %Adding information
    Dz = dir([PreProcPath, filesep, FilePrefix(1:end - 1), filesep, FilePrefix(1:end - 1), '*001*.tif']);
    NumberSlices = length(Dz) - 1;
    
    for i = 1:length(FrameInfo)
        FrameInfo(i).NumberSlices = NumberSlices;
    end
    
end

end

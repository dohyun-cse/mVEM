function showmesh(node,elem,options)
%Showmesh displays a mesh in 2-D and 3-D.
%
% Copyright (C) Terence Yu

if nargin==2, options.FaceAlpha = 0.4; end

dim = size(node,2);
if ~iscell(elem)
    h = patch('Faces', elem, 'Vertices', node);    
end
if iscell(elem)
    if iscell(elem{1}), elem = vertcat(elem{:}); end
    max_n_vertices = max(cellfun(@length, elem));
    padding_func = @(vertex_ind) [vertex_ind,...
        NaN(1,max_n_vertices-length(vertex_ind))];  % function to pad the vacancies
    tpad = cellfun(padding_func, elem, 'UniformOutput', false);
    tpad = vertcat(tpad{:});
    h = patch('Faces', tpad, 'Vertices', node);
end

if dim==3
    view(3); set(h,'FaceAlpha',options.FaceAlpha); % transparency
end

if isfield(options,'facecolor')
    facecolor = options.facecolor;
else
    facecolor = [0.5 0.9 0.45];
end
set(h,'facecolor',facecolor,'edgecolor','k');
axis equal; axis tight;

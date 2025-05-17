Here you can test the performance between GPU instancing and static batching
The Prefabs folder contains two prefabs where you can compare the performance between high poly and low poly meshes
Just set the correct prefab on the "GpuVsStatic" GameObject (Field "To instantiate"), then run the test!
The "DrawInstanced" GameObject allows you to benchmark the performance of "Graphics.DrawMeshInstanced", turn that GameObject on, and turn "GpuVsStatic" off to benchmark its performance
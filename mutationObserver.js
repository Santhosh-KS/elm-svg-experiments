
// https://www.youtube.com/watch?v=Mi4EF9K87aM


/* onclick
var onclick: ((this: Window, ev: MouseEvent) => any) | null
Fires when the user clicks the left mouse button on the object */

let mutationObserver = new MutationObserver(entries => {
  console.log(entries)

// https://github.com/Santhosh-KS/ts_experiments/commit/e4d3506e7f44418b19060f3d35b16335b70b45f8?diff=unified&w=0#diff-b88b6f03474fb9b485a2602cd87ff396e8d86a943fbb06196a586292484e3e28
  let svg  = document.querySelector('#MainSvg') 
      let pt = svg.createSVGPoint()
      pt.x = e.clientX
      pt.y = e.clientY
     
      let t = svg.getScreenCTM() 
      pt = pt.matrixTransform(t.inverse())
      console.log(pt)
      return {
        x:pt.x ,
        y:pt.y 
      };
})

const parent = document.querySelector("#MainSvg")
mutationObserver.observe(parent, { childList: true,
  subtree: true,
  // if you want to observer the mutation on the editable text 
  characterData: true,
  characterDataOldValue: true, 
  // if you want to observer the mutation on the attributes
  attributes:true,
  attributeOldValue:true,
  // attributeFilter: ["id", "x", "y"]
})

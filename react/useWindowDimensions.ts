import { useEffect, useState } from "react";

type WindowDimensions = {
  width?: number;
  height?: number;
};

export default function useWindowDimensions() {
  const [dimensions, set] = useState<WindowDimensions>();

  useEffect(() => {
    function handleResize() {
      set({
        width: window.innerWidth,
        height: window.innerHeight,
      });
    }

    handleResize();

    window.addEventListener("resize", handleResize);

    return () => window.removeEventListener("resize", handleResize);
  }, []);

  return dimensions;
}
